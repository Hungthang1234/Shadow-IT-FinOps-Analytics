# 🛡️ Enterprise SaaS FinOps & Shadow IT Monitoring

![MySQL](https://img.shields.io/badge/MySQL-00000F?style=for-the-badge&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-14354C?style=for-the-badge&logo=python&logoColor=white)
![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Scikit-Learn](https://img.shields.io/badge/scikit_learn-F7931E?style=for-the-badge&logo=scikit-learn&logoColor=white)

## 📖 Tổng quan dự án (Project Overview)
Trong bối cảnh chuyển đổi số, việc các phòng ban tự ý sử dụng phần mềm chưa được phê duyệt (Shadow IT) gây ra rủi ro lớn về bảo mật và lãng phí ngân sách (SaaS Waste). 

Dự án này xây dựng một luồng dữ liệu End-to-End (từ ETL, thiết kế Data Warehouse đến Machine Learning) nhằm theo dõi, phân tích và tối ưu hóa chi phí phần mềm (FinOps), đồng thời phát hiện các rủi ro bảo mật từ Shadow IT.

**Mục tiêu chính:**
- Phân tích chi phí SaaS hàng tháng và nhận diện sự lãng phí tài nguyên.
- Ứng dụng thuật toán phân cụm (K-Means) để phân loại hành vi người dùng và đánh giá mức độ rủi ro (Risk Level).
- Xây dựng hệ thống cơ sở dữ liệu chuẩn hóa, sẵn sàng tích hợp với các công cụ BI (Power BI/Tableau).

---

## 🏗️ Kiến trúc dữ liệu (Data Architecture)
Hệ thống sử dụng cơ sở dữ liệu quan hệ được thiết kế chuẩn hóa để quản lý nhân sự, danh mục phần mềm, lịch sử đăng nhập SSO và hóa đơn. 

Dữ liệu sau khi xử lý ETL và chạy thuật toán phân cụm được lưu trữ ngược lại (write-back) vào bảng `fact_shadow_it_clustered` để phục vụ báo cáo.

![Entity Relationship Diagram](link_hinh_anh_FinOps_ERD_cua_ban.png)
> *Sơ đồ Thực thể Liên kết (ERD) được thiết kế và xuất từ MySQL Workbench.*

---

## 🧠 Phân tích & Mô hình hóa (Data Science Workflow)
Dự án áp dụng quy trình Khoa học Dữ liệu toàn diện:
1. **ETL & Data Cleaning (Python - Pandas/NumPy):** Xử lý dữ liệu thô, làm sạch và tạo các feature mới (Feature Engineering).
2. **Clustering (Scikit-Learn/R):** Sử dụng thuật toán K-Means Clustering kết hợp PCA để phân nhóm mức độ rủi ro của người dùng dựa trên hành vi đăng nhập phần mềm trái phép.
3. **Data Warehousing (MySQL):** Tạo các Views (`vw_user_software_activity`) và Stored Procedures để tự động hóa luồng báo cáo.
4. **Visualization (R Markdown):** Trực quan hóa kết quả phân cụm (Cluster Plots) và biểu đồ phân tán rủi ro (Risk Scatter Plots).

---

## 📊 Kết quả phân tích (Key Insights)
*(Tại đây, bạn hãy chèn 1-2 biểu đồ đẹp nhất từ R Markdown và tóm tắt 2-3 gạch đầu dòng về insight bạn tìm được. Ví dụ:)*

*   **Cụm Rủi ro cao (High Risk):** Chiếm x% nhân sự, chủ yếu từ phòng ban Y, thường xuyên sử dụng các phần mềm chia sẻ file không an toàn.
*   **Lãng phí ngân sách (FinOps Waste):** Phát hiện $Z chi phí cho các tài khoản SaaS đã được mua nhưng không có log đăng nhập trong 3 tháng qua.

---

## 📂 Cấu trúc Repository (Folder Structure)
```text
├── data/                   # Dữ liệu mẫu (CSV/Excel)
├── database/               # File SQL script tạo bảng, Views, Stored Procedures
├── notebooks/              # Jupyter Notebooks cho quá trình ETL và K-Means
├── reports/                # File Rmd và báo cáo HTML/PDF đã render
├── images/                 # Hình ảnh ERD, biểu đồ cho file README
└── README.md               # Tổng quan dự án