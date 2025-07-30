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
        <li><a href="customers.jsp" class="nav-link">🧑‍🤝‍🧑 Customers</a></li>
        <li><a href="items.jsp" class="nav-link">📦 Items</a></li>
        <li><a href="accountDetails.jsp" class="nav-link active">🗂️ Account Details</a></li>
        <li><a href="billing.jsp" class="nav-link">💳 Billing</a></li>
        <li><a href="help.jsp" class="nav-link">🆘 Help</a></li>
        <li><a href="reports.jsp" class="nav-link">📈 Reports</a></li>
      </ul>
    </nav>

    <div class="logout-container">
      <button class="btn-dark">Log Out</button>
    </div>
  </aside>

  <!-- Main Content -->
  <main class="main">
    <h1 class="title">🔍 Search Customer Account</h1>

    <!-- Search Box -->
    <div class="search-box">
      <form method="get">
        <input type="text" name="accountNumber" placeholder="Enter Account Number" required />
        <button type="submit">Search</button>
      </form>
    </div>

    <!-- Display Area -->
    <div class="details">
      <div class="detail-row">
        <div class="label">Account Number:</div>
        <div class="value">1001</div>
      </div>
      <div class="detail-row">
        <div class="label">Full Name:</div>
        <div class="value">Dimalsha Sachinthani</div>
      </div>
      <div class="detail-row">
        <div class="label">Address:</div>
        <div class="value">123 Lotus Avenue, Colombo</div>
      </div>
      <div class="detail-row">
        <div class="label">Telephone:</div>
        <div class="value">0771234567</div>
      </div>
      <div class="detail-row">
        <div class="label">Units Consumed:</div>
        <div class="value">150</div>
      </div>
    </div>
  </main>
</div>

</body>



<head>
  <meta charset="UTF-8">
  <title>Pahana Edu | Account Details</title>
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
            font-weight: 400;
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
            flex-grow: 1;
            padding: 30px;
            overflow-y: auto;
          }

    /* Main Content */
    .main {
      flex-grow: 1;
      padding: 50px;
    }

    .title {
      font-size: 38px;
      color: #805acb;
      margin-bottom: 30px;
    }

    .search-box {
      background: #f3e9f7;
      padding: 20px 30px;
      border-radius: 16px;
      box-shadow: 0 4px 10px rgba(205, 180, 219, 0.3);
      margin-bottom: 40px;
    }

    .search-box input[type="text"] {
      padding: 12px;
      width: 250px;
      border: 1px solid #ccc;
      border-radius: 10px;
      margin-right: 10px;
    }

    .search-box button {
      padding: 12px 20px;
      background-color: #cdb4db;
      color: white;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      font-weight: 600;
      transition: 0.3s;
    }

    .search-box button:hover {
      background-color: #b79ed1;
    }

    .details {
      background: #f3e9f7;
      padding: 30px;
      border-radius: 16px;
      box-shadow: 0 4px 10px rgba(186, 170, 255, 0.2);
      max-width: 700px;
    }

    .detail-row {
      display: flex;
      margin-bottom: 20px;
    }

    .label {
      width: 180px;
      font-weight: bold;
      color: #7c6589;
    }

    .value {
      background: #fff;
      padding: 10px 15px;
      border-radius: 10px;
      box-shadow: 0 2px 6px rgba(186, 170, 255, 0.1);
      flex-grow: 1;
    }
  </style>
</head>
</html>
