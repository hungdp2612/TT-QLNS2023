using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ErrorMessage
/// </summary>
namespace GiaThanhSanPhamMay
{
    public class ErrorMessage
    {
        public ErrorMessage()
        {
           
        }

        public const string NoConnectionString = "Không tìm thấy thông tin kết nối đến Server. Vui lòng thông báo đến TTTH";

        public const string ChuaPhanQuyen = "Bạn chưa được phân quyền vào chức năng này. Thông báo TTTH để được phân quyền.";

        public const string KhongDuocPhep = "Bạn không được phép vào sử dụng chức năng này.";

        public const string ReadOnly = "Bạn chỉ được phép đọc, không được phân quyền cho phép thêm , xóa , sửa .....";

        public const string Saidulieunhap = "Dữ liệu nhập chưa đầy đủ, hoặc bạn nhập không chính xác. Xin vui lòng kiểm tra lại dữ liệu nhập";
    }
}