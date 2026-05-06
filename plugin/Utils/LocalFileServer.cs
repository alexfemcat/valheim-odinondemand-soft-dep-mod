using System;
using System.IO;
using System.Net;
using System.Threading;
using Logger = Jotunn.Logger;

namespace OdinOnDemand.Utils
{
    public static class LocalFileServer
    {
        private static HttpListener _listener;
        private static Thread _thread;
        private static string _mediaDirectory;
        private static int _port;

        public static int Port => _port;
        public static bool IsRunning => _listener != null && _listener.IsListening;

        public static void Start(string mediaDirectory)
        {
            if (IsRunning) return;

            _mediaDirectory = mediaDirectory;
            _port = FindFreePort();

            _listener = new HttpListener();
            _listener.Prefixes.Add($"http://127.0.0.1:{_port}/");

            try
            {
                _listener.Start();
                _thread = new Thread(HandleRequests) { IsBackground = true, Name = "OOD-LocalFileServer" };
                _thread.Start();
                Logger.LogInfo($"[LocalFileServer] Started on port {_port}, serving: {mediaDirectory}");
            }
            catch (Exception e)
            {
                Logger.LogError($"[LocalFileServer] Failed to start: {e.Message}");
                _listener = null;
            }
        }

        public static void Stop()
        {
            if (_listener == null) return;
            try { _listener.Stop(); } catch { }
            _listener = null;
        }

        public static string GetUrl(string filename)
        {
            if (!IsRunning) return null;
            return $"http://127.0.0.1:{_port}/{Uri.EscapeDataString(filename)}";
        }

        private static void HandleRequests()
        {
            while (_listener != null && _listener.IsListening)
            {
                try
                {
                    var ctx = _listener.GetContext();
                    ThreadPool.QueueUserWorkItem(_ => ServeFile(ctx));
                }
                catch { break; }
            }
        }

        private static void ServeFile(HttpListenerContext ctx)
        {
            try
            {
                string filename = Uri.UnescapeDataString(ctx.Request.Url.AbsolutePath.TrimStart('/'));
                string fullPath = Path.Combine(_mediaDirectory, filename);

                if (!File.Exists(fullPath))
                {
                    ctx.Response.StatusCode = 404;
                    ctx.Response.Close();
                    return;
                }

                ctx.Response.StatusCode = 200;
                ctx.Response.ContentType = GetMimeType(filename);

                using var fs = File.OpenRead(fullPath);
                ctx.Response.ContentLength64 = fs.Length;
                fs.CopyTo(ctx.Response.OutputStream);
                ctx.Response.OutputStream.Close();
            }
            catch (Exception e)
            {
                Logger.LogError($"[LocalFileServer] Error serving file: {e.Message}");
                try { ctx.Response.StatusCode = 500; ctx.Response.Close(); } catch { }
            }
        }

        private static string GetMimeType(string filename)
        {
            var ext = Path.GetExtension(filename).ToLowerInvariant();
            return ext switch
            {
                ".mp4"  => "video/mp4",
                ".webm" => "video/webm",
                ".ogg"  => "audio/ogg",
                ".mp3"  => "audio/mpeg",
                ".wav"  => "audio/wav",
                ".flac" => "audio/flac",
                _       => "application/octet-stream"
            };
        }

        private static int FindFreePort()
        {
            var listener = new System.Net.Sockets.TcpListener(IPAddress.Loopback, 0);
            listener.Start();
            int port = ((IPEndPoint)listener.LocalEndpoint).Port;
            listener.Stop();
            return port;
        }
    }
}
