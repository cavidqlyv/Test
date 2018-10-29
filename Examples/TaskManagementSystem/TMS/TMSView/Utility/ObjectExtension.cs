using System;

namespace TMSView.Utility
{
    public static class ObjectExtension
    {
        public static string GetDate(this object dateTime)
        {
            DateTime dt = (DateTime)dateTime;
            return string.Concat(dt.Month, "/", dt.Day, "/", dt.Year);

        }
    }
}