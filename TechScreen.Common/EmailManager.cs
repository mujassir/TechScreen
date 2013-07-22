using System.Text;
using System.Net.Mail;

namespace TechScreen.Common
{
    public static class EmailManager
    {
        /// <summary>
        /// Email helper class to send emails. Gets the email settings from Web.config.
        /// </summary>
        /// <param name="emailAddress"></param>
        /// <param name="subject"></param>
        /// <param name="mailBody"></param>
        public static void SendEmail(string emailAddress, string subject, string mailBody)
        {
            var message = new MailMessage
                {
                    Body = mailBody,
                    BodyEncoding = Encoding.UTF8,
                    Subject = subject,
                    SubjectEncoding = Encoding.UTF8,
                    IsBodyHtml = true
                };

            message.To.Add(new MailAddress(emailAddress));
            using (var smtp = new SmtpClient())
            {
                try
                {
                    smtp.Send(message);
                }

                finally
                {
                    smtp.Dispose();
                    message.Dispose();
                }
            }
        }
    }
}
