<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="main.model.Customer" %>
<%
    Customer customer = (Customer) request.getAttribute("customer");
%>

<%@ page import="main.model.Item" %>
<%@ page import="java.util.List" %>

<%
    List<Item> items = (List<Item>) request.getAttribute("items");
%>

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
        <li><a href="billing.jsp" class="nav-link active">💳 Billing</a></li>
        <li><a href="help.jsp" class="nav-link">🆘 Help</a></li>
        <li><a href="reports.jsp" class="nav-link">📈 Reports</a></li>
      </ul>
    </nav>
    <div class="logout-container">
      <button class="btn-dark">Log Out</button>
    </div>
  </aside>




<!-- Main Wrapper -->
<div class="main">
  <h2 class="title">Billing Page</h2>

  <!-- 🔍 Search Box -->
  <div class="search-box">
    <form method="get" action="SearchCustomer">
      <input type="text" name="accountNumber" placeholder="Enter Account Number" />
      <input type="text" name="name" placeholder="Or Enter Customer Name" />
      <button type="submit">Search</button>
    </form>
  </div>

  <!-- 👤 Customer Details -->

  <div class="details">
    <% if (customer != null) { %>
      <div class="detail-row">
        <div class="label">Account Number:</div>
        <div class="value"><%= customer.getaccNo() %></div>
      </div>
      <div class="detail-row">
        <div class="label">Full Name:</div>
        <div class="value"><%= customer.getName() %></div>
      </div>
    <% } else if (request.getParameter("accountNumber") != null || request.getParameter("name") != null) { %>
      <p style="color: red;">❌ No customer found with that information.</p>
    <% } %>
  </div>



  <!-- Billing Content -->
    <div class="billing-main">

      <!-- Left: Item List -->
      <div class="item-list">
              <% if (items != null && !items.isEmpty()) {
                   for (Item item : items) { %>
                <div class="item">
                  <h4 class="item-name"><%= item.getName() %></h4>
                  <p class="item-price">Rs. <%= item.getPrice() %></p>
                  <button class="add-to-cart">Add to Cart</button>
                </div>
              <% }
                 } else { %>
                <p>No items found.</p>
              <% } %>
            </div>



      <!-- Right: Cart Panel -->
      <div class="cart">
          <h3>Cart</h3>
          <div class="cart-items"></div>

          <hr style="margin: 20px 0; border-color: #d2bfff;" />

          <div class="cart-item" style="font-weight: bold;">
            <span>Total</span>
            <span id="total-price">Rs. 0</span>
          </div>

          <button class="checkout">Checkout</button>

        <!--  Popup Modal -->
         <div class="modal hidden">
              <div class="modal-content">
                <span class="close">&times;</span>
                <h3>Order Summary</h3>
                <div id="modal-summary"></div>
                <hr />
                <h4>Customer Details</h4>
                <% if (customer != null) { %>
                  <form>
                    <div class="detail-row">
                      <div class="label">Full Name:</div>
                      <div class="value"><%= customer.getName() %></div>
                    </div>
                    <div class="detail-row">
                      <div class="label">Address:</div>
                      <div class="value"><%= customer.getAddress() %></div>
                    </div>
                    <div class="detail-row">
                      <div class="label">Contact Number:</div>
                      <div class="value"><%= customer.getPhone() %></div>
                    </div>
                    <div class="detail-row">
                      <div class="label">Email:</div>
                      <div class="value"><%= customer.getEmail() %></div>
                    </div>
                    <button type="submit">Confirm Order</button>
                  </form>
                <% } else { %>
                  <p style="color:red;">❌ Customer data not found. Please perform a search or login first.</p>
                <% } %>
              </div>
    </div>
  </div>
</div>
</div>

</body>




<script>
  document.addEventListener('DOMContentLoaded', () => {
    const cart = {};
    let total = 0;

    const cartItemsContainer = document.querySelector('.cart-items');
    const totalPriceSpan = document.getElementById('total-price');
    const modal = document.querySelector('.modal');
    const modalClose = document.querySelector('.close');
    const checkoutBtn = document.querySelector('.checkout');
    const modalSummary = document.getElementById('modal-summary');

    // Handle Add to Cart
    document.querySelectorAll('.add-to-cart').forEach(button => {
      button.addEventListener('click', () => {
        const itemElement = button.closest('.item');
        const itemName = itemElement.querySelector('.item-name').textContent.trim();
        const itemPrice = parseInt(itemElement.querySelector('.item-price').textContent.replace('Rs. ', ''));

        if (cart[itemName]) {
          cart[itemName].quantity += 1;
        } else {
          cart[itemName] = {
            price: itemPrice,
            quantity: 1
          };
        }

        updateCartDisplay();
      });
    });

    // Update Cart UI
    function updateCartDisplay() {
      cartItemsContainer.innerHTML = '';
      total = 0;

      for (const [name, item] of Object.entries(cart)) {
        const itemTotal = item.price * item.quantity;
        total += itemTotal;

        const div = document.createElement('div');
        div.className = 'cart-item';
        div.innerHTML = `
          <span>${name}</span>
          <div class="quantity-controls">
            <button class="decrease" data-name="${name}">−</button>
            <span class="quantity">${item.quantity}</span>
            <button class="increase" data-name="${name}">+</button>
          </div>
          <span class="price">Rs. ${itemTotal}</span>
        `;

        cartItemsContainer.appendChild(div);
      }

      totalPriceSpan.textContent = `Rs. ${total}`;
      attachQtyButtonListeners();
    }

    // Attach + and − listeners
    function attachQtyButtonListeners() {
      document.querySelectorAll('.increase').forEach(btn => {
        btn.addEventListener('click', () => {
          const name = btn.dataset.name;
          cart[name].quantity++;
          updateCartDisplay();
        });
      });

      document.querySelectorAll('.decrease').forEach(btn => {
        btn.addEventListener('click', () => {
          const name = btn.dataset.name;
          if (cart[name].quantity > 1) {
            cart[name].quantity--;
          } else {
            delete cart[name];
          }
          updateCartDisplay();
        });
      });
    }

    // Checkout: Show Modal
    checkoutBtn.addEventListener('click', () => {
      modalSummary.innerHTML = '';

      for (const [name, item] of Object.entries(cart)) {
        const line = document.createElement('p');
        line.textContent = `${name} x ${item.quantity} - Rs. ${item.price * item.quantity}`;
        modalSummary.appendChild(line);
      }

      const totalLine = document.createElement('p');
      totalLine.innerHTML = `<strong>Total: Rs. ${total}</strong>`;
      modalSummary.appendChild(totalLine);

      modal.classList.remove('hidden');
    });

    // Close Modal
    modalClose.addEventListener('click', () => {
      modal.classList.add('hidden');
    });
  });
</script>







<head>
  <meta charset="UTF-8">
  <title>Pahana Edu | Billing</title>
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
             width: 285px;
             height: 100vh; /* full height */
             background: rgba(255, 255, 255, 0.95);
             backdrop-filter: blur(12px);
             border-radius: 0 20px 20px 0;
             box-shadow: 0 8px 24px rgba(186, 170, 255, 0.3);
             padding: 20px;
             display: flex;
             flex-direction: column;
             justify-content: space-between;
             z-index: 10;
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


    /* Billing Content */
    .billing-main {
      margin-left: 285px;
      margin-right: 300px;
      flex-grow: 1;
      display: flex;
      padding: 40px;
      gap: 30px;
    }

    /* Item List */
    .item-list {
      flex-grow: 1;
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 48px;
    }

    .item {
      background: #f3e9f7;
      border-radius: 12px;
      padding: 20px;
      box-shadow: 0 4px 10px rgba(186, 170, 255, 0.2);
      text-align: center;
    }

    .item h4 {
      margin-bottom: 10px;
      color: #805acb;
    }

    .item p {
      margin-bottom: 10px;
      font-size: 14px;
      color: #6a5a87;
    }

    .item button {
      background-color: #cdb4db;
      border: none;
      padding: 10px 18px;
      border-radius: 20px;
      color: white;
      cursor: pointer;
      font-weight: bold;
      transition: 0.3s ease;
    }

    .item button:hover {
      background-color: #b79ed1;
    }

    /* Cart Section */
        .cart {
          position: fixed;
            top: 0;
            right: 0;
            width: 300px;
            height: 100vh;
            background: #e9d8fd;
            border-radius: 20px 0 0 20px;
            padding: 20px;
            box-shadow: -4px 0 10px rgba(186, 170, 255, 0.2);
            overflow-y: auto;
            z-index: 10;
        }

        .cart h3 {
          text-align: center;
          margin-bottom: 20px;
          color: #5c4a72;
        }

        .cart-item {
          display: flex;
          justify-content: space-between;
          margin-bottom: 15px;
          padding: 10px;
          background: #fff;
          border-radius: 10px;
          box-shadow: 0 2px 6px rgba(186, 170, 255, 0.1);
        }

        .cart-item span {
          font-size: 14px;
          font-weight: 500;
          color: #5c4a72;
        }

        .checkout {
          margin-top: 20px;
          background-color: #a084e8;
          color: white;
          width: 100%;
          padding: 12px;
          border: none;
          border-radius: 30px;
          cursor: pointer;
          font-weight: bold;
          transition: 0.3s ease;
        }

        .checkout:hover {
          background-color: #8e6cd0;
        }

        .quantity-controls {
          display: inline-flex;
          align-items: center;
          gap: 7px;
          margin: 0 10px;
        }

        .quantity-controls button {
          padding: 2px 6px;
          background-color: #a084e8;
          font-size: 16px;
          cursor: pointer;
          border-radius: 30px;
          color: white;
        }


        .modal {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(75, 0, 130, 0.4); /* purple overlay */
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
          }

          .hidden {
            display: none;
          }

          .modal-content {
            background: #f8f0ff;
            padding: 20px;
            border-radius: 12px;
            width: 350px;
            color: #4b0082;
            box-shadow: 0 0 10px #dabfff;
            position: relative;
          }

          .modal-content h3, .modal-content h4 {
            margin-top: 0;
          }

          .modal-content input {
            width: 100%;
            padding: 8px;
            margin-top: 8px;
            border: 1px solid #dabfff;
            border-radius: 5px;
            font-size: 14px;
          }

          .modal-content button {
            background: #a96dff;
            border: none;
            margin-top: 15px;
            padding: 10px;
            color: white;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
          }

          .close {
            position: absolute;
            top: 5px;
            right: 15px;
            font-size: 22px;
            cursor: pointer;
            color: #4b0082;
          }





    .search-box {
      background: #f3e8ff;
      padding: 20px;
      margin-bottom: 20px;
      border-radius: 10px;
      margin-left: 300px;
    }

    .search-box form {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }

    .search-box input {
      padding: 8px;
      border: 1px solid #d2bfff;
      border-radius: 5px;
      min-width: 200px;
    }

    .search-box button {
      padding: 8px 16px;
      background-color: #cba3ff;
      border: none;
      border-radius: 5px;
      color: #4b0082;
      font-weight: bold;
      cursor: pointer;
    }

    .details {
      margin-top: 15px;
      margin-left: 310px;
    }

    .detail-row {
      display: flex;
      gap: 10px;
      margin-bottom: 5px;
    }

    .label {
      font-weight: bold;
      color: #4b0082;
    }

    .value {
      color: #333;
    }


  </style>
</head>

</html>
