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
using System.IO;

public class clsConvertHelper
{
    public clsConvertHelper()
    {

    }
    //Chuyển đối tượng về kiểu int
    //Nếu lỗi thì chuyển giá trị về mặc định def
    public static int ToInt(object val, int def)
    {
        try
        {
            return Convert.ToInt32(val);
        }
        catch
        {
            return def;
        }
    }

    //Chuyển đối tượng về kiểu int
    //Nếu lỗi thì chuyển mặc định về 0;
    public static int ToInt(object val)
    {
        return ToInt(val, 0);
    }

    //Chuyển đối tượng về kiểu long
    //Nếu lỗi thì chuyển giá trị về mặc định def
    public static long ToLong(object val, long def)
    {
        try
        {
            return long.Parse(val.ToString());
        }
        catch
        {
            return def;
        }
    }

    //Chuyển đối tượng về kiểu long
    //Nếu lỗi thì chuyển mặc định về 0;
    public static long ToLong(object val)
    {
        return ToLong(val, 0);
    }

    public static string ToString(object val, string def)
    {
        try
        {
            return Convert.ToString(val);
        }
        catch
        {
            return def;
        }
    }

    public static string ToString(object val)
    {
        return ToString(val, "");
    }

    public static double ToDouble(object val, double def)
    {
        try
        {
            return Convert.ToDouble(val);
        }
        catch
        {
            return def;
        }
    }

    public static double ToDouble(object val)
    {
        return ToDouble(val, 0);
    }
    public static float ToFloat(object val, float def)
    {
        try
        {
            return Convert.ToSingle(val);
        }
        catch
        {
            return def;
        }

    }
    public static float ToFloat(object val)
    {
        return ToFloat(val, 0);
    }

    public static DateTime ToDateTime(object val, DateTime def)
    {
        try
        {
            return Convert.ToDateTime(val);
        }
        catch
        {
            return def;
        }
    }

    public static DateTime ToDateTime(object val)
    {
        return ToDateTime(val, DateTime.MinValue);
    }

    public static decimal ToDecimal(object val, decimal def)
    {
        try
        {
            return Convert.ToDecimal(val);
        }
        catch
        {
            return def;
        }
    }
    public static bool Tobool(object val)
    {
        try
        {
            return Convert.ToBoolean(val);
        }
        catch
        {
            return false;
        }
    }
    public static decimal ToDecimal(object val)
    {
        return ToDecimal(val, 0);
    }
    public static byte[] imageToByteArray(System.Drawing.Image imageIn)
    {
        MemoryStream ms = new MemoryStream();
        imageIn.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
        return ms.ToArray();
    }
    public static System.Drawing.Image byteArrayToImage(byte[] byteArrayIn)
    {
        MemoryStream ms = new MemoryStream(byteArrayIn);
        System.Drawing.Image returnImage = System.Drawing.Image.FromStream(ms);
        return returnImage;
    }
    public static string ReturnEncodedBase64UTF8(object rawImg)
    {
        try
        {
            string img = "data:image/gif;base64,{0}"; //change image type if need be
            byte[] toEncodeAsBytes = (byte[])rawImg;
            string returnValue = System.Convert.ToBase64String(toEncodeAsBytes);
            return String.Format(img, returnValue);
        }
        catch
        {
            return null;
        }
    }
    public static byte[] ReadFile(string sPath)
    {
        try
        {
            //Initialize byte array with a null value initially.
            byte[] data = null;

            //Use FileInfo object to get file size.
            FileInfo fInfo = new FileInfo(sPath);
            long numBytes = fInfo.Length;

            //Open FileStream to read file
            FileStream fStream = new FileStream(sPath, FileMode.Open, FileAccess.Read);

            //Use BinaryReader to read file stream into byte array.
            BinaryReader br = new BinaryReader(fStream);

            //When you use BinaryReader, you need to supply number of bytes 
            //to read from file.
            //In this case we want to read entire file. 
            //So supplying total number of bytes.
            data = br.ReadBytes((int)numBytes);

            return data;
        }
        catch
        {
            return null;
        }
    }

    private static string[] ChuSo = new string[10] { " không", " một", " hai", " ba", " bốn", " năm", " sáu", " bẩy", " tám", " chín" };
    private static string[] Tien = new string[6] { "", " nghìn", " triệu", " tỷ", " nghìn tỷ", " triệu tỷ" };
    // Hàm đọc số thành chữ
    public static string DocSo_TiengViet(long SoTien, string strTail)
    {
        int lan, i;
        long so;
        string KetQua = "", tmp = "";
        int[] ViTri = new int[6];
        if (SoTien < 0) return "Số tiền âm !";
        if (SoTien == 0) return "Không đồng !";
        if (SoTien > 0)
        {
            so = SoTien;
        }
        else
        {
            so = -SoTien;
        }
        //Kiểm tra số quá lớn
        if (SoTien > 8999999999999999)
        {
            SoTien = 0;
            return "";
        }
        ViTri[5] = (int)(so / 1000000000000000);
        so = so - long.Parse(ViTri[5].ToString()) * 1000000000000000;
        ViTri[4] = (int)(so / 1000000000000);
        so = so - long.Parse(ViTri[4].ToString()) * +1000000000000;
        ViTri[3] = (int)(so / 1000000000);
        so = so - long.Parse(ViTri[3].ToString()) * 1000000000;
        ViTri[2] = (int)(so / 1000000);
        ViTri[1] = (int)((so % 1000000) / 1000);
        ViTri[0] = (int)(so % 1000);
        if (ViTri[5] > 0)
        {
            lan = 5;
        }
        else if (ViTri[4] > 0)
        {
            lan = 4;
        }
        else if (ViTri[3] > 0)
        {
            lan = 3;
        }
        else if (ViTri[2] > 0)
        {
            lan = 2;
        }
        else if (ViTri[1] > 0)
        {
            lan = 1;
        }
        else
        {
            lan = 0;
        }
        for (i = lan; i >= 0; i--)
        {
            tmp = DocSo3ChuSo(ViTri[i]);
            KetQua += tmp;
            if (ViTri[i] != 0) KetQua += Tien[i];
            if ((i > 0) && (!string.IsNullOrEmpty(tmp))) KetQua += ",";//&& (!string.IsNullOrEmpty(tmp))
        }
        if (KetQua.Substring(KetQua.Length - 1, 1) == ",") KetQua = KetQua.Substring(0, KetQua.Length - 1);
        KetQua = KetQua.Trim() + strTail;
        return KetQua.Substring(0, 1).ToUpper() + KetQua.Substring(1);
    }
    // Hàm đọc số có 3 chữ số
    private static string DocSo3ChuSo(int baso)
    {
        int tram, chuc, donvi;
        string KetQua = "";
        tram = (int)(baso / 100);
        chuc = (int)((baso % 100) / 10);
        donvi = baso % 10;
        if ((tram == 0) && (chuc == 0) && (donvi == 0)) return "";
        if (tram != 0)
        {
            KetQua += ChuSo[tram] + " trăm";
            if ((chuc == 0) && (donvi != 0)) KetQua += " linh";
        }
        if ((chuc != 0) && (chuc != 1))
        {
            KetQua += ChuSo[chuc] + " mươi";
            if ((chuc == 0) && (donvi != 0)) KetQua = KetQua + " linh";
        }
        if (chuc == 1) KetQua += " mười";
        switch (donvi)
        {
            case 1:
                if ((chuc != 0) && (chuc != 1))
                {
                    KetQua += " mốt";
                }
                else
                {
                    KetQua += ChuSo[donvi];
                }
                break;
            case 5:
                if (chuc == 0)
                {
                    KetQua += ChuSo[donvi];
                }
                else
                {
                    KetQua += " lăm";
                }
                break;
            default:
                if (donvi != 0)
                {
                    KetQua += ChuSo[donvi];
                }
                break;
        }
        return KetQua;
    }
    public static string DocSo_TiengAnh(double so_doi, string don_vi, string dv_le)
    {
        string functionReturnValue = null;
        int xx;
        //dynamic yy = null;
        int m_loai = 0;
        int m_count = 0;
        int m_a = 0;
        int m_len = 0;
        double m_so;
        //dynamic m_temp = null;
        string m_val;
        double so_le;
        string[] a_so = null;
        string[] a_dv = null;
        a_so = new string[5];
        a_dv = new string[4];
        so_le = Math.Round((so_doi - Convert.ToInt64(so_doi)), 2) * 100;
        so_doi = Convert.ToInt64(so_doi);
        m_so = so_doi;
        m_len = m_so.ToString().Length;
        if (m_len > 12)
        {
            //MsgBox so_doi & " >  999 billion "
            functionReturnValue = "";
            return functionReturnValue;
        }
        m_count = 3 - (m_len % 3);
        m_count = m_count % 3;
        m_a = 0;
        m_loai = 0;
        for (xx = 0; xx < m_len; xx++)
        {
            m_count = m_count + 1;
            m_loai = m_loai + 1;
            switch (m_so.ToString().Substring(xx, 1))
            {
                case "0":
                    a_dv[m_count] = "zero";
                    break;
                case "1":
                    a_dv[m_count] = "one";
                    break;
                case "2":
                    a_dv[m_count] = "two";
                    break;
                case "3":
                    a_dv[m_count] = "three";
                    break;
                case "4":
                    a_dv[m_count] = "four";
                    break;
                case "5":
                    a_dv[m_count] = "five";
                    break;
                case "6":
                    a_dv[m_count] = "six";
                    break;
                case "7":
                    a_dv[m_count] = "seven";
                    break;
                case "8":
                    a_dv[m_count] = "eight";
                    break;
                case "9":
                    a_dv[m_count] = "nine";
                    break;
            }
            if (m_count % 3 == 0)
            {
                switch (a_dv[2])
                {
                    case "zero":
                        a_dv[2] = "";
                        break;
                    case "two":
                        a_dv[2] = "twenty";
                        break;
                    case "three":
                        a_dv[2] = "thirty";
                        break;
                    case "four":
                        a_dv[2] = "fourty";
                        break;
                    case "five":
                        a_dv[2] = "fifty";
                        break;
                    case "six":
                        a_dv[2] = "sixty";
                        break;
                    case "seven":
                        a_dv[2] = "seventy";
                        break;
                    case "eight":
                        a_dv[2] = "eighty";
                        break;
                    case "nine":
                        a_dv[2] = "ninety";
                        break;
                }
                if (a_dv[1] == "zero")
                {
                    a_dv[1] = "";
                }

                if (!string.IsNullOrEmpty(a_dv[1]))
                {
                    a_dv[1] = a_dv[1] + " hundred";
                }
                if (a_dv[3] == "zero" & a_dv[2] != "one")
                {
                    a_dv[3] = "";
                }

                switch (a_dv[2] + a_dv[3])
                {
                    case "onezero":
                        m_val = a_dv[1] + " ten";
                        break;
                    case "oneone":
                        m_val = a_dv[1] + " eleven";
                        break;
                    case "onetwo":
                        m_val = a_dv[1] + " twelve";
                        break;
                    case "onethree":
                        m_val = a_dv[1] + " thirteen";
                        break;
                    case "onefour":
                        m_val = a_dv[1] + " fourteen";
                        break;
                    case "onefive":
                        m_val = a_dv[1] + " fifteen";
                        break;
                    case "onesix":
                        m_val = a_dv[1] + " sixteen";
                        break;
                    case "oneseven":
                        m_val = a_dv[1] + " seventeen";
                        break;
                    case "oneight":
                        m_val = a_dv[1] + " eighteen";
                        break;
                    case "onenine":
                        m_val = a_dv[1] + " nineteen";
                        break;
                    default:
                        m_val = a_dv[1] + " " + a_dv[2] + " " + a_dv[3] + " ";
                        break;
                }
                a_dv = new string[4];
                m_a = m_a + 1;
                a_so[m_a] = m_val.Trim();
                m_val = "";
                m_loai = 0;
                m_count = 0;
            }
        }
        m_val = "";
        for (xx = 1; xx <= m_a; xx++)
        {
            switch (m_a)
            {
                case 1:
                    m_val = m_val + a_so[xx] + " ";
                    break;
                case 2:
                    switch (xx)
                    {
                        case 1:
                            m_val = m_val + a_so[xx] + " thoundsand ";
                            break;
                        case 2:
                            m_val = m_val + a_so[xx];
                            break;
                    }
                    break;
                case 3:
                    switch (xx)
                    {
                        case 1:
                            m_val = m_val + a_so[xx] + " million ";
                            break;
                        case 2:
                            m_val = m_val + a_so[xx] + " thoundsand ";
                            break;
                        case 3:
                            m_val = m_val + a_so[xx];
                            break;
                    }
                    break;
                case 4:
                    switch (xx)
                    {
                        case 1:
                            m_val = m_val + a_so[xx] + " billion ";
                            break;
                        case 2:
                            m_val = m_val + a_so[xx] + " million ";
                            break;
                        case 3:
                            m_val = m_val + a_so[xx] + " thoundsand ";
                            break;
                        case 4:
                            m_val = m_val + a_so[xx];
                            break;
                    }
                    break;
            }
        }
        //m_val = m_val.Substring(0, 1) + m_val.Substring(1, m_val.Length-2);
        if (so_le == 0)
        {
            functionReturnValue = m_val + " " + don_vi;
        }
        else
        {
            functionReturnValue = m_val + " " + don_vi + " And " + DocSo_TiengAnh(so_le, "", "") + dv_le;
        }
        return functionReturnValue;
    }
}
