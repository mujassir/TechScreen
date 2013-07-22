namespace TechScreen.Common
{
    public enum RecordStatus
    {
        Active = 0,
        Inactive = 1,
        Deleted = 2,
        Blocked = 3,

    }
    public enum MessageType
    {
        Info = 1,
        Success = 2,
        Warning = 3,
        Error = 4
    }
    public enum UserRole
    {
        Admin = 1,
        SupperUser = 2,
        ClientUser = 3,
    }
}