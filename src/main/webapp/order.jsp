<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="main.model.Order" %>
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
        <li><a href="AccountDetails" class="nav-link">🗂 Account Details</a></li>
        <li><a href="BillingPage" class="nav-link">💳 Billing</a></li>
        <li><a href="help.jsp" class="nav-link">🆘 Help</a></li>
        <li><a href="Order" class="nav-link">📈 Orders</a></li>
      </ul>
    </nav>
    <div class="logout-container">
      <button class="btn-dark">Log Out</button>
    </div>
  </aside>

  <!-- Main Content -->
  <main class="main">
    <h2 class="title">📦 Order List</h2>

    <div class="table-container">
      <h3>All Orders</h3>
      <table>
        <thead>
          <tr>
            <th>Order ID</th>
            <th>Customer ID</th>
            <th>Items (JSON)</th>
            <th>Total (Rs.)</th>
            <th>Created At</th>
          </tr>
        </thead>
        <tbody>
       <tbody>
       <%
           List<Order> orders = (List<Order>) request.getAttribute("orders");
           if (orders != null && !orders.isEmpty()) {
               for (Order order : orders) {
       %>
           <tr>
               <td><%= order.getId() %></td>
               <td><%= order.getCustomerId() %></td>
               <td><%= order.getItemsJson() %></td>
               <td><%= order.getTotal() %></td>
               <td><%= order.getCreatedAt() %></td>
           </tr>
       <%
               }
           } else {
       %>
           <tr>
               <td colspan="5" class="no-data">No orders available.</td>
           </tr>
       <%
           }
       %>
       </tbody>


        </tbody>
      </table>
    </div>
  </main>
</div>

</body>

<head>
  <meta charset="UTF-8">
  <title>Pahana Edu | Orders</title>
  <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
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

    .sidebar {
      position: fixed;
      width: 285px;
      height: 100vh;
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
    }

    .nav-link {
      display: block;
      padding: 18px 15px;
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

    .nav-link.active {
      background-color: #e1d0ff;
      color: #6f42c1;
      font-weight: 600;
    }

    .btn-dark {
      width: 100%;
      padding: 12px;
      background: linear-gradient(90deg, #a084e8, #d5c9ff);
      color: white;
      border: none;
      border-radius: 40px;
      cursor: pointer;
    }

    .btn-dark:hover {
      background: linear-gradient(90deg, #8b6edb, #c6b9ff);
      box-shadow: 0 4px 10px rgba(186, 170, 255, 0.3);
    }

    .main {
      margin-left: 285px;
      flex-grow: 1;
      padding: 40px;
    }

    .title {
      font-size: 30px;
      color: #5c4a72;
      margin-bottom: 30px;
    }

    .table-container h3 {
      margin-bottom: 15px;
      color: #7c6589;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      box-shadow: 0 4px 10px rgba(186, 170, 255, 0.2);
      border-radius: 10px;
      overflow: hidden;
    }

    table th, table td {
      padding: 15px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }

    table th {
      background: #e9d8fd;
      color: #5c4a72;
    }

    .no-data {
      padding: 20px;
      color: #888;
      text-align: center;
    }

    .logout-container {
      text-align: center;
      margin-top: 20px;
    }
  </style>
</head>
</html>