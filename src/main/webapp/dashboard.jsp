<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Pahana Edu | Dashboard</title>
  <link rel="stylesheet" href="css/dashboard.css">
  <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="layout">
  <!-- Sidebar -->
  <aside class="sidebar">
    <nav>
      <ul class="nav">
        <li><a href="dashboard.jsp" class="nav-link">📚 Dashboard</a></li>
        <li><a href="customers.jsp" class="nav-link">🧑‍🤝‍🧑 Customers</a></li>
        <li><a href="#" class="nav-link">📦 Items</a></li>
        <li><a href="#" class="nav-link">🗂 Account Details</a></li>
        <li><a href="#" class="nav-link">💳 Billing</a></li>
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
        <div class="card" onclick="location.href='customers.jsp'" style="cursor: pointer;">👥 Customers</div>
        <div class="card" onclick="location.href='items.jsp'" style="cursor: pointer;">📦 Items</div>
        <div class="card" onclick="location.href='account.jsp'" style="cursor: pointer;">🗂 Account Details</div>
        <div class="card" onclick="location.href='billing.jsp'" style="cursor: pointer;">🧾 Billing</div>
        <div class="card" onclick="location.href='help.jsp'" style="cursor: pointer;">📘 Help</div>
        <div class="card" onclick="location.href='reports.jsp'" style="cursor: pointer;">🧮 Reports</div>
      </div>
    </section>
  </main>
</div>

</body>
</html>