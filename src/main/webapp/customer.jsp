<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="main.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Pahana Edu | Customers</title>
  <link rel="stylesheet" href="css/customers.css">
  <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="layout">
  <!-- Sidebar -->
  <aside class="sidebar">
    <nav>
      <ul class="nav">
        <li><a href="dashboard.jsp" class="nav-link">📚 Dashboard</a></li>
        <li><a href="CustomerList" class="nav-link active">🧑‍🤝‍🧑 Customers</a></li>
      </ul>
    </nav>
    <div class="logout-container">
      <button class="btn-dark">Log Out</button>
    </div>
  </aside>

  <!-- Main Content -->
  <main class="main">
    <h2 class="title">👥 Customer Management</h2>

    <!-- Add Customer Form -->
    <form class="customer-form" action="Customer" method="post">
      <h3>Add New Customer</h3>
      <div class="form-group">
        <input type="text" name="accNo" placeholder="Account Number" required />
        <input type="text" name="name" placeholder="Full Name" required />
      </div>
      <div class="form-group">
        <input type="text" name="address" placeholder="Address" required />
        <input type="tel" name="phone" placeholder="Telephone Number" required />
      </div>
      <div class="form-group">
        <input type="email" name="email" placeholder="Email Address" required />
      </div>
      <button type="submit" class="btn-submit">Add Customer</button>
    </form>

    <c:if test="${param.success == 'true'}">
      <p style="color: green;">Customer Added Successfully!</p>
    </c:if>

    <!-- Customer Table -->
    <div class="table-container">
      <h3>Customer Accounts</h3>
      <table>
        <thead>
          <tr>
            <th>Account No</th>
            <th>Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Email</th>
          </tr>
        </thead>
        <tbody>
          <%
            List<Customer> customers = (List<Customer>) request.getAttribute("customers");
            if (customers != null) {
              for (Customer customer : customers) {
          %>
          <tr>
            <td><%= customer.getaccNo() %></td>
            <td><%= customer.getName() %></td>
            <td><%= customer.getAddress() %></td>
            <td><%= customer.getPhone() %></td>
            <td><%= customer.getEmail() %></td>
          </tr>
          <%
              }
            } else {
          %>
          <tr>
            <td colspan="5">No customers found.</td>
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
</html>
