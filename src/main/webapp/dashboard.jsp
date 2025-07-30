<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<body>

<div class="layout">
  <!-- Sidebar -->
  <aside class="sidebar">
    <nav>
      <ul class="nav">
        <li><a href="dashboard.jsp" class="nav-link">📚 Dashboard</a></li>
        <li><a href="Customer" class="nav-link">🧑‍🤝‍🧑 Customers</a></li>
        <li><a href="Item" class="nav-link">📦 Items</a></li>
        <li><a href="accountDetails.jsp" class="nav-link">🗂 Account Details</a></li>
        <li><a href="billing.jsp" class="nav-link">💳 Billing</a></li>
        <li><a href="#" class="nav-link">🆘 Help</a></li>
        <li><a href="" class="nav-link">📈 Reports</a></li>
      </ul>
    </nav>

    <div class="logout-container">
      <button class="btn-dark" >Log Out</button>
    </div>
  </aside>

  <!-- Main Dashboard Content -->
  <main class="main">
    <!-- Topbar -->
    <div class="topbar">
      <input type="text" placeholder="Search books..." />
      <div class="profile">👤</div>
    </div>

    <!-- Banner -->
    <section class="banner">
      <div>
        <h1>Hello 👋</h1>
        <p>Manage your customers, items, and bills all in one place. Let’s make your bookshop thrive! 📚</p>
        <button>Get Started</button>
      </div>
      <img src="https://cdn-icons-png.flaticon.com/512/3014/3014732.png" alt="Books" />
    </section>

    <!-- Grid Cards -->
        <section class="grid-section">
          <div class="grid">
            <div class="card">
              👥 Total Customers
              <button class="detail-btn">View Details</button>
            </div>
            <div class="card">
              📦 Total Items
              <button class="detail-btn">View Details</button>
            </div>
            <div class="card">
              🧾 Bills Generated Today
              <button class="detail-btn">View Details</button>
            </div>
            <div class="card">
              🆕 New Customers Today
              <button class="detail-btn">View Details</button>
            </div>
            <div class="card">
              🗂️ Account Details
              <button class="detail-btn">View Details</button>
            </div>
            <div class="card">
              ➕ Add Customer
              <button class="detail-btn">View Details</button>
            </div>
            <div class="card">
              ➕ Add Item
              <button class="detail-btn">View Details</button>
            </div>
            <div class="card">
              🧮 Calculate & Print Bill
              <button class="detail-btn">View Details</button>
            </div>
            <div class="card">
              📘 Open Help Guide
              <button class="detail-btn">View Details</button>
            </div>
            <div class="card">
              📘 Open Help Guide
              <button class="detail-btn">View Details</button>
            </div>
          </div>
        </section>
  </main>
</div>

</body>



<head>
  <meta charset="UTF-8">
  <title>Pahana Edu | Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Raleway:wght@400;600;700&display=swap');

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Raleway', sans-serif;
    }

    body {
      background: #f9f5ff;
      color: #444;
    }

    .layout {
      display: flex;
      min-height: 100vh;
    }

    /* Sidebar */
    .sidebar {
      position: fixed;
      top: 0;
      left: 0;
      z-index: 10;
      width: 285px;
      height: 670px;
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(12px);
      border-radius: 0 20px 20px 0;
      box-shadow: 0 8px 24px rgba(186, 170, 255, 0.3);
      padding: 20px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .nav {
      list-style: none;
      padding: 0;
    }

    .nav-link {
      display: block;
      padding: 18px 18px;
      font-size: 20px;
      border-radius: 12px;
      transition: 0.3s;
      color: #444;
      font-weight: 500;
      text-decoration: none;
    }

    .nav-link:hover {
      background-color: rgba(224, 210, 255, 0.5);
      color: #a084e8;
      font-weight: 600;
    }

    .btn-dark {
      width: 100%;
      padding: 12px;
      font-size: 15px;
      background: linear-gradient(90deg, #a084e8, #d5c9ff);
      border: none;
      color: white;
      border-radius: 40px;
      cursor: pointer;
      transition: 0.3s ease;
      margin-bottom: 30px;
    }

    .btn-dark:hover {
      background: linear-gradient(90deg, #8b6edb, #c6b9ff);
      box-shadow: 0 4px 10px rgba(186, 170, 255, 0.3);
    }

    .logout-container {
      text-align: center;
    }

    /* Main Section */
    .main {
      margin-left: 285px;
      flex-grow: 1;
      padding: 30px;
      overflow-y: auto;
    }

    /* Topbar */
    .topbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
    }

    .topbar input {
      padding: 10px 20px;
      border-radius: 25px;
      border: 1px solid #ddd;
      width: 60%;
    }

    .profile {
      background: #cdb4db;
      color: white;
      border-radius: 50%;
      padding: 10px;
      font-size: 18px;
      cursor: pointer;
    }

    /* Banner */
    .banner {
      background: linear-gradient(120deg, #f3e9f7, #e9d8fd);
      margin-bottom: 40px;
      padding: 30px;
      border-radius: 20px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
    }

    .banner img {
      height: 100px;
      margin-top: 15px;
    }

    .banner h1 {
      font-size: 24px;
      color: #5c4a72;
    }

    .banner p {
      color: #7c6589;
      margin: 10px 0;
    }

    .banner button {
      background-color: #cdb4db;
      color: white;
      padding: 8px 20px;
      border: none;
      border-radius: 20px;
      cursor: pointer;
      margin-top: 10px;
    }

    /* Grid Cards */
    .grid-section {
      padding-bottom: 40px;
    }

    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
      gap: 23px;
      padding: 10px;
    }

    .card {
      background-color: #fff;
      border-radius: 16px;
      padding: 20px;
      box-shadow: 0 4px 12px rgba(205, 180, 219, 0.3);
      transition: 0.3s ease;
      font-size: 17px;
      text-align: center;
    }

    .card:hover {
      transform: scale(1.02);
    }

    .detail-btn {
      margin-top: 12px;
      background-color: #cdb4db;
      border: none;
      color: white;
      padding: 6px 14px;
      border-radius: 20px;
      font-size: 14px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .detail-btn:hover {
      background-color: #b28cc8;
    }
  </style>
</head>
</html>