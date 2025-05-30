using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;
using System.Xml;
using System.Collections.Generic;

/// <summary>
/// Summary description for clssys
/// </summary>
public class clssys
{
	public clssys()
	{
		//
		// TODO: Add constructor logic here
		//
       
	}
    string[] chuSo = new string[10] { "", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín" };
    string[] chuCach = new string[4] { "", "tỷ", "ngàn", "triệu" };

    string SoTram2Chu(uint soCanDoi)
    {
        uint soHangChuc, soHangTram, soHangDonVi;
        string str = null;
        //Xác định 3 ký số miêu tả hàng trăm, hàng chục và đơn vị
        soHangTram = soCanDoi / 100;
        soCanDoi = soCanDoi % 100;
        soHangChuc = soCanDoi / 10;
        soHangDonVi = soCanDoi % 10;
        if (soHangTram >= 1)
            str = chuSo[soHangTram] + " trăm";
        if (soHangChuc >= 2)
            str = str + " " + chuSo[soHangChuc] + " mươi";
        if (soHangChuc == 1)
            str = str + " mười";
        if (soHangDonVi == 0) return str;
        if (soHangChuc == 0)
        {
            if (soHangTram != 0)
                str = str + " lẻ" + chuSo[soHangDonVi];
            else str = str + " " + chuSo[soHangDonVi];
            return str;
        }
        if (soHangChuc == 1)
        {
            if (soHangDonVi != 5)
                str = str + " " + chuSo[soHangDonVi];
            else
                str = str + " lăm";
            return str;
        }
        if (soHangDonVi == 1)
            str = str + " mốt";
        else if (soHangDonVi == 5) str = str + " lăm";
        else str = str + " " + chuSo[soHangDonVi];
        return str;

    }

    public string So2Chu(long soCanDoi)
    {
        int idx = 0;//Vị trí dấu chấm phân cách từng 3 ký số
        long baKySo = 0;
        string str = null;
        string tram = null;
        string tuNganCach = null;
        if (soCanDoi == 0)
        {
            str = "không";
        }
        else
        {
            while (soCanDoi != 0)
            {
                baKySo = soCanDoi % 1000;
                soCanDoi = soCanDoi / 1000;
                tram = SoTram2Chu(Convert.ToUInt32(baKySo));
                if (idx == 0)
                {//vị trí đơn vị
                    if (soCanDoi == 0)
                        str = tram;
                    else str = " lẻ " + tram;
                }
                else if (tram.Length != 0)
                {//vị trí ngàn, triệu, tỷ
                    tuNganCach = chuCach[(idx % 3) + 1];
                    str = tram + " " + tuNganCach + " " + str;
                }
                else if ((idx % 3) == 0)
                    str = " tỷ" + str;
                idx = idx + 1;
            }
        }
        return str;
    }
    public string DoiSoThanhChu(string socandoi)
    {
        string so = "";
        return so;
    }
   



    public string CutChuoi(string Str, char c, int i)
    {
        string Chuoi = "";
        string Phieu = Str;
        int Count = Str.Length;
        int dem = 0;
        int Flast = 0;
        foreach (char cut in Phieu)
        {

            if (Flast == 0)
            {
                dem++;
            }
            if (cut.ToString() == c.ToString())
            {
                Flast = 1;
            }

        }
        int d = dem;
        if (i == 1)
        {
            Chuoi = Phieu.Substring(0, dem - 1);
        }
        int vt2 = 0;
        vt2 = Count - dem;
        if (i == 2)
        {
            Chuoi = Phieu.Substring(dem, vt2);
        }



        return Chuoi;
    }

    public string ReadNumber(string Number)
    {
        string read = "";
        string Number1 = "";
        string Number2 = "";

        Number1 = CutChuoi(Number, '.', 1);
        Number2 = CutChuoi(Number, '.', 2);
        if (Number2 == "")
        {
            try
            {
                Number1 = Number;
                read = So2Chu(Convert.ToInt64(Number1));
            }
            catch
            {
                Number1 = CutChuoi(Number, '.', 1);
                read = So2Chu(Convert.ToInt64(Number1));
            }
        }
        try
        {
            if (Number2 != "")
            {
                read = So2Chu(Convert.ToInt64(Number1));
                read = read + " phẩy " + So2Chu(Convert.ToInt64(Number2));
            }

        }
        catch
        {
            try
            {
                read = So2Chu(Convert.ToInt64(CutChuoi(Number, '.', 1)));
            }
            catch
            {
                read = "không" + " phẩy " + So2Chu(Convert.ToInt64(Number2));
            }
        }

        return read;

    }

    public string GetrTime(string date)
    {
        string dt;
        string ngay = date.Substring(0, 2);
        string thang = date.Substring(3, 2);
        string nam = date.Substring(6, 4);
        dt = ngay + thang + nam;
        return dt;
    }
  
  

    private static readonly string[] VietnameseSigns = new string[] { "aAeEoOuUiIdDyY", "áàạảãâấầậẩẫăắằặẳẵ", "ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ", "éèẹẻẽêếềệểễ", "ÉÈẸẺẼÊẾỀỆỂỄ", "óòọỏõôốồộổỗơớờợởỡ", "ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ", "úùụủũưứừựửữ", "ÚÙỤỦŨƯỨỪỰỬỮ", "íìịỉĩ", "ÍÌỊỈĨ", "đ", "Đ", "ýỳỵỷỹ", "ÝỲỴỶỸ" };

    public string RemoveSign4VietnameseString(string str)
    {
        for (int i = 1; i < VietnameseSigns.Length; i++) 
        {
            for (int j = 0; j < VietnameseSigns[i].Length; j++)   
   
           str = str.Replace(VietnameseSigns[i][j], VietnameseSigns[0][i - 1]); 
        }
        return str;
    }
    //send mail
    public void SendMail(string Addressmail, string cc, string subject, string noidung)
    {
        if (cc == "")
        {
            HttpContext.Current.Response.Redirect("mailto:" + Addressmail +  "?subject=" + subject + "&body=" + noidung + "");
        }
        else
        {
            HttpContext.Current.Response.Redirect("mailto:" + Addressmail + "?cc=" + cc + "&subject=" + subject + "&body=" + noidung + "");
        }
    }
}

public class Exrate
{
    private string _CurrencyCode = string.Empty;

    public string CurrencyCode
    {
        get { return _CurrencyCode; }
        set { _CurrencyCode = value; }
    }
    private string _CurrencyName = string.Empty;

    public string CurrencyName
    {
        get { return _CurrencyName; }
        set { _CurrencyName = value; }
    }
    private float _Buy = 0;

    public float Buy
    {
        get { return _Buy; }
        set { _Buy = value; }
    }
    private float _Transfer = 0;

    public float Transfer
    {
        get { return _Transfer; }
        set { _Transfer = value; }
    }
    private float _Sell = 0;

    public float Sell
    {
        get { return _Sell; }
        set { _Sell = value; }
    }
}

public class GetTyGia
{
    public GetTyGia()
    {

    }
    private string GetWebContent(string strLink)
    {
        string strContent = "";
        try
        {
            WebRequest objWebRequest = WebRequest.Create(strLink);

            objWebRequest.Credentials = CredentialCache.DefaultCredentials;

            WebResponse objWebResponse = objWebRequest.GetResponse();
            Stream receiveStream = objWebResponse.GetResponseStream();
            StreamReader readStream = new StreamReader(receiveStream, System.Text.Encoding.UTF8);

            strContent = readStream.ReadToEnd();
            objWebResponse.Close();
            readStream.Close();
        }
        catch
        {
        }
        return strContent;
    }
    public string ExchangeRates1(string LoaiTien)
    {
        string TiGia = "";
        try
        {
            Match match;
            string strHTML = this.GetWebContent("http://www.vietcombank.com.vn/");
            strHTML = Regex.Replace(strHTML, "\t|\r|\n", "");
            match = Regex.Match(strHTML, ConfigurationSettings.AppSettings["RegexVietcombank"].ToString());

            while (match.Success)
            {
                if (match.Groups["ExchangeName"].ToString() == LoaiTien)
                {
                    TiGia = match.Groups["ExchangeRate1"].ToString();
                    return TiGia;
                }
                match = match.NextMatch();
            }
           
        }
        catch
        {
            return "";
        }
        return TiGia;
    }



    public string ExchangeRates(string LoaiTien)
    {
        string TiGia = "";
        try
        {
            XmlDocument xmlDocument = new XmlDocument();
            String xmlSourceUrl = "https://portal.vietcombank.com.vn/Usercontrols/TVPortal.TyGia/pXML.aspx?b=1";
            xmlDocument.Load(xmlSourceUrl);

            //từ đây hoàn toàn có thể thao tác dữ liệu xml bằng đối tượng xmlDocument
            //lấy ví zụ chuyển từ XmlDocument thành tập các đối tượng Generic dạng List<Exrate>
            XmlNodeList nodeList = xmlDocument.GetElementsByTagName("Exrate");
            List<Exrate> listExrate = null;
            if (nodeList != null && nodeList.Count > 0)
            {
                listExrate = new List<Exrate>();
                foreach (XmlNode xmlNode in nodeList)
                {
                    Exrate entityExrate = new Exrate();

                    if (xmlNode.Attributes["CurrencyCode"].InnerText == LoaiTien)
                    {
                        TiGia = xmlNode.Attributes["Buy"].InnerText;
                        return TiGia;
                    }
                   
                    //entityExrate.CurrencyCode = xmlNode.Attributes["CurrencyCode"].InnerText;
                    //entityExrate.CurrencyName = xmlNode.Attributes["CurrencyName"].InnerText;
                    //entityExrate.Buy = float.Parse(xmlNode.Attributes["Buy"].InnerText);
                    //entityExrate.Transfer = float.Parse(xmlNode.Attributes["Transfer"].InnerText);
                    //entityExrate.Sell = float.Parse(xmlNode.Attributes["Sell"].InnerText);

                    //listExrate.Add(entityExrate);
                }

                //thực hiện việc bind dữ liệu vào GridView

              
            }

            //DataSet ds = new DataSet();
            //ds.ReadXml(new XmlNodeReader(xmlDocument));
            ////hoặc có thể chuyển XmlDocument thành DataSet để hiển thị dữ liệu trên các đối tượng trình bày dữ liệu một cách dễ dàng hơn
            ////ở đây lấy ví zụ là GridView
            //gridViewTyGia.DataSource = ds;
            //gridViewTyGia.DataBind();
        }
        catch(Exception ex)
        {
            return "";
        }
        return TiGia;
    }
}