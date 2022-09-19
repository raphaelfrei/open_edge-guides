using System;
using System.DirectoryServices;

namespace RF {
    public class Control {

        public static string AzureLogin(string user, string password, string domain) {

            string status;

            try {
                new DirectorySearcher(new DirectoryEntry("LDAP://" + domain, user, password) {
                    AuthenticationType = AuthenticationTypes.Secure,
                    Username = user,
                    Password = password

                }) {
                    Filter = "(objectclass=user)"
                }.FindOne().Properties["displayname"][0].ToString();

                status = "SUCCESS - User " + user + " has logged in.";

            } catch (System.Exception e) {
                status = "ERROR - While logging in: " + e.ToString();

            }

            return status;
        }
    }
}
