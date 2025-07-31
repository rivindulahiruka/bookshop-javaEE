<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="main.model.Item" %>

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
        <li><a href="AccountDetails" class="nav-link">🗂️ Account Details</a></li>
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
    <h2 class="title">📦 Item Management</h2>

    <!-- Add/Update Item Form -->
    <form class="item-form" method="post" action="<%= request.getContextPath() %>/Item">
    <div class="form-group">
        <input type="text" name="itemCode" placeholder="Item Code" required />
        <input type="text" name="itemName" placeholder="Item Name" required />
    </div>
    <div class="form-group">
        <input type="number" step="0.01" name="price" placeholder="Price" required />
        <input type="number" name="stock" placeholder="Stock" required />
    </div>
        <input type="hidden" name="action" id="formAction" value="add" />

        <button class="btn-submit" type="submit">Save Item</button>
    </form>


    <!-- Item Table -->
    <div class="table-container">
      <h3>Item List</h3>
      <table>
        <thead>
          <tr>
            <th>Item Code</th>
            <th>Name</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <%
              List<main.model.Item> items = (List<main.model.Item>) request.getAttribute("items");
              if (items != null) {
                  for (main.model.Item item : items) {
          %>
          <tr>
              <td><%= item.getItemCode() %></td>
              <td><%= item.getName() %></td>
              <td><%= item.getPrice() %></td>
              <td><%= item.getStock() %></td>
              <td>
                  <button
                    class="btn-edit"
                    data-code="<%= item.getItemCode() %>"
                    data-name="<%= item.getName() %>"
                    data-price="<%= item.getPrice() %>"
                    data-stock="<%= item.getStock() %>">Edit</button>

               <form method="post" action="<%= request.getContextPath() %>/Item">

                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="id" value="<%= item.getId() %>"/>
                        <button type="submit" class="btn-delete"
                                onclick="return confirm('Are you sure you want to delete this item?');">
                            Delete
                        </button>
                    </form>


              </td>
          </tr>
          <%
                  }
              } else {
          %>
          <tr>
              <td colspan="5">No items found.</td>
          </tr>
          <%
              }
          %>

        </tbody>
      </table>
    </div>
  </main>
</div>

</body>






<script>
  // When DOM is ready
  document.addEventListener('DOMContentLoaded', () => {
    const editButtons = document.querySelectorAll('.btn-edit');
    const form = document.querySelector('.item-form');
    const inputCode = form.querySelector('input[name="itemCode"]');
    const inputName = form.querySelector('input[name="itemName"]');
    const inputPrice = form.querySelector('input[name="price"]');
    const inputStock = form.querySelector('input[name="stock"]');
    const actionInput = document.getElementById('formAction');

    editButtons.forEach(button => {
      button.addEventListener('click', () => {

        inputCode.value = button.getAttribute('data-code');
        inputName.value = button.getAttribute('data-name');
        inputPrice.value = button.getAttribute('data-price');
        inputStock.value = button.getAttribute('data-stock');

        inputCode.readOnly = true;

        actionInput.value = 'update';

        form.querySelector('.btn-submit').textContent = 'Update Item';
      });
    });
  });
</script>






<head>
  <meta charset="UTF-8">
  <title>Pahana Edu | Items</title>
  <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/favicon.ico.png">

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
    padding: 18px 15px;
    font-size: 20px;
    border-radius: 12px;
    transition: 0.3s;
    color: #444;
    font-weight: 500;
    text-decoration: none;
  }

  .nav-link:hover,
  .nav-link.active {
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

  /* Main Content */
  .main {
    margin-left: 285px;
    flex-grow: 1;
    padding: 40px;
    overflow-y: auto;
  }

  .title {
    font-size: 30px;
    color: #5c4a72;
    margin-bottom: 30px;
  }

  /* Form */
  .item-form {
    background: #f3e9f7;
    padding: 30px;
    border-radius: 16px;
    box-shadow: 0 4px 10px rgba(205, 180, 219, 0.3);
    margin-bottom: 40px;
  }

  .item-form h3 {
    margin-bottom: 20px;
    color: #7c6589;
  }

  .form-group {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
    flex-wrap: wrap;
  }

  .item-form input {
    flex: 1;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 10px;
  }

  .btn-submit {
    background-color: #cdb4db;
    color: white;
    border: none;
    padding: 12px 25px;
    border-radius: 30px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s ease;
  }

  .btn-submit:hover {
    background-color: #b79ed1;
  }

  /* Table */
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

  .btn-edit,
  .btn-delete {
    padding: 6px 12px;
    border: none;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
  }

  .btn-edit {
    background-color: #a084e8;
    color: white;
    margin-right: 10px;
  }

  .btn-delete {
    background-color: #ff6b81;
    color: white;
  }

  </style>
</head>

</html>
