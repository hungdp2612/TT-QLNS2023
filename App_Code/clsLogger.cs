using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Data;
public class clsLogger
{

    public clsLogger()
    {

    }
    public static void Write(string errorMessage,string maNV, string className, string functionName)
    {
        clsObj Obj;
        clsSql Sql = new clsSql();
        Obj = new clsObj();
        Obj.Parameter = new string[] {"@Error","@MaNV","@ClassName","@FunctionName" };
        Obj.ValueParameter = new object[] {errorMessage,maNV,className,functionName };
        Obj.SpName = "spInsert_nd_Error";
        Sql.fNonGetData(Obj);
    }
}
