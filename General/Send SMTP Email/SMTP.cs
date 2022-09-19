using System;

namespace RF {

    public static class SMTP {

        public static string SendHTMLEmail(string? sendTo, string? subject, string? path, string? sendAs, string? ip) {

            try {
                using (StreamReader reader = File.OpenText(path)) {
                    System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();

                    foreach (var address in sendTo.Split(new[] { ";" }, StringSplitOptions.RemoveEmptyEntries)) {
                        message.To.Add(address);

                    }

                    message.Subject = subject;
                    message.From = new System.Net.Mail.MailAddress(sendAs);

                    message.IsBodyHtml = true;
                    message.Body = reader.ReadToEnd();

                    if (message.Body == "")
                        message.Body = $"Error - Not possible to read file or it's blank\n{path}";

                    System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(ip);

                    smtp.Send(message);

                    return $"SUCCESS - Email sent to: {sendTo}";
                }

            } catch (System.Exception ex) {

                try {
                    System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();

                    foreach (var address in sendTo.Split(new[] { ";" }, StringSplitOptions.RemoveEmptyEntries)) {
                        message.To.Add(address);

                    }

                    message.Subject = subject;
                    message.From = new System.Net.Mail.MailAddress(sendAs);

                    message.IsBodyHtml = true;
                    message.Body = $"Error - Not possible to read or file is empty\n{path}\n{ex}";

                    System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(ip);

                    smtp.Send(message);

                    return $"ERROR - Sent error infos to: {sendTo}";

                } catch (System.Exception) {

                }

                return $"ERROR - While sending HTML Email: {ex}";

            }
        }

    }
}
