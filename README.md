\# 🛡️ Phân cụm Rủi ro Shadow IT (Shadow IT Risk Clustering)



\## 📖 Giới thiệu Dự án

Dự án này tập trung vào việc xây dựng một pipeline phân tích dữ liệu để giám sát và phân loại mức độ rủi ro \*\*Shadow IT\*\* (Sử dụng phần mềm công nghệ ngoài tầm kiểm soát của tổ chức). 



Bằng cách áp dụng thuật toán học máy không giám sát \*\*K-Means Clustering\*\*, mô hình tự động gom cụm hành vi của người dùng thành các nhóm rủi ro (Low, Medium, High) dựa trên các chỉ số đo lường như chi phí hàng tháng (`MonthlyCostPerUser`), tần suất đăng nhập (`TotalLogins`), và số lượng ứng dụng trái phép.



\## 🛠️ Công nghệ Sử dụng

\* \*\*Truy xuất \& Quản lý dữ liệu:\*\* SQL (MySQL/SQL Server)

\* \*\*Mô hình hóa \& Phân tích:\*\* R (RStudio)

\* \*\*Thư viện R:\*\* `dplyr` (Data manipulation), `ggplot2`, `factoextra` (Data visualization \& Clustering)

\* \*\*Trực quan hóa Hệ thống \& BI:\*\* draw.io, Power BI



\## 🚀 Trạng thái \& Kế hoạch Triển khai (Roadmap)

Dự án đang trong quá trình phát triển (Work in Progress). Dưới đây là các đầu mục công việc:



\- \[x] \*\*Xây dựng Data Pipeline:\*\* Thiết lập luồng trích xuất dữ liệu từ cơ sở dữ liệu (ETL).

\- \[x] \*\*Data Preprocessing:\*\* Xử lý giá trị thiếu (`na.omit`), làm sạch dữ liệu và chuẩn hóa (`scale()`).

\- \[x] \*\*Modeling (Giai đoạn 1):\*\* Xử lý lỗi nhiễu phương sai (variance = 0), thực hiện phân cụm 1 chiều (1D K-Means) và vẽ biểu đồ phân phối Density Plot.

\- \[ ] \*\*Data Architecture:\*\* Vẽ sơ đồ cấu trúc dữ liệu (ERD) và luồng kết nối dữ liệu bằng \*\*draw.io\*\* / \*\*Power BI\*\*.

\- \[ ] \*\*Data Quality Fix:\*\* Cải thiện logic truy vấn SQL đầu nguồn để đảm bảo tính biến thiên của các chỉ số hành vi.

\- \[ ] \*\*Modeling (Giai đoạn 2):\*\* Chạy lại mô hình K-Means đa chiều và hoàn thiện bản đồ phân tán (Scatter Plot) với `fviz\_cluster`.



\## 📂 Cấu trúc Repository

```text

├── data/                  # Chứa file dữ liệu mẫu hoặc script tạo bảng SQL

├── diagrams/              # Chứa sơ đồ luồng dữ liệu và thiết kế hệ thống

├── scripts/

│   ├── 01\_db\_helper.R     # Script kết nối và truy xuất CSDL

│   └── 02\_kmeans\_model.R  # Script xử lý dữ liệu, chuẩn hóa và huấn luyện K-Means

└── README.md              # Tài liệu dự án

