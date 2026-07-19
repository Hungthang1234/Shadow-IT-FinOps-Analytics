PROJECT\_STATUS

\# ⏸️ Trạng thái Dự án: Phân cụm Rủi ro Shadow IT (K-Means)



\*\*Ngày cập nhật:\*\* 20/07/2026

\*\*Trạng thái:\*\* Tạm dừng để xử lý dữ liệu gốc.



\## 1. Tóm tắt Vấn đề Hiện tại

\* \*\*Lỗi gặp phải:\*\* Hàm `scale()` trong R báo lỗi `NaN/Inf` khi chuẩn hóa dữ liệu, dẫn đến không thể vẽ bản đồ phân tán 2D bằng `fviz\_cluster`.

\* \*\*Nguyên nhân cốt lõi:\*\* Cột `TotalLogins` lấy từ cơ sở dữ liệu hiện có phương sai bằng 0 (tất cả các dòng đều có cùng một giá trị 0).

\* \*\*Giải pháp tạm thời đã thực hiện:\*\* Chuyển sang phân cụm 1 chiều (1D K-Means) sử dụng duy nhất biến `MonthlyCostPerUser` và trực quan hóa thành công bằng biểu đồ Density Plot (`ggplot2`).



\## 2. Kế hoạch Triển khai Tiếp theo (Next Steps)

Khi tiếp tục dự án, các đầu việc cần thực hiện theo thứ tự:



\- \[ ] \*\*Kiểm tra và sửa lỗi ETL/SQL:\*\* Truy vấn lại cơ sở dữ liệu để sửa lỗi logic khiến cột `TotalLogins` không có sự biến thiên (kiểm tra lại các lệnh JOIN hoặc GROUP BY).

\- \[ ] \*\*Thiết kế Data Diagram:\*\* 

&#x20; \* Lập bản đồ cấu trúc dữ liệu và luồng dữ liệu (ERD/Data Lineage) từ SQL.

&#x20; \* Sử dụng các công cụ hỗ trợ như \*\*draw.io\*\* hoặc \*\*Power BI\*\* để vẽ sơ đồ.

\- \[ ] \*\*Trực quan hóa dữ liệu (Data Visualization) bằng R:\*\* 

&#x20; \* Sau khi dữ liệu SQL đã chuẩn xác, đưa lại vào R.

&#x20; \* Chạy lại mô hình K-Means với tối thiểu 2 biến (`MonthlyCostPerUser` và `TotalLogins`).

&#x20; \* Hoàn thiện bản đồ phân cụm rủi ro bằng `fviz\_cluster`.

