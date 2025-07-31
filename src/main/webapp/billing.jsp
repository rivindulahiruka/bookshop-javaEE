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
<head>
  <meta charset="UTF-8">
  <title>Pahana Edu | Billing</title>
  <!-- jsPDF CDN -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
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
      height: 100vh;
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

    .nav-link:hover, .nav-link.active {
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
      padding: 20px;
      flex-grow: 1;
    }

    .title {
      margin-bottom: 20px;
      color: #5c4a72;
      text-align: center;
    }

    .search-box {
      background: #f3e8ff;
      padding: 20px;
      margin-bottom: 20px;
      border-radius: 10px;
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
      margin-bottom: 20px;
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

    /* Billing Content */
    .billing-main {
      display: flex;
      gap: 30px;
      margin-right: 320px;
    }

    /* Item List */
    .item-list {
      flex-grow: 1;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 20px;
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
      align-items: center;
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

    .quantity-controls {
      display: flex;
      align-items: center;
      gap: 7px;
    }

    .quantity-controls button {
      padding: 2px 6px;
      background-color: #a084e8;
      border: none;
      font-size: 16px;
      cursor: pointer;
      border-radius: 30px;
      color: white;
    }

    .quantity-controls button:hover {
      background-color: #8e6cd0;
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

    .checkout:disabled {
      background-color: #ccc;
      cursor: not-allowed;
    }

    /* Modal */
    .modal {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-color: rgba(75, 0, 130, 0.4);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 1000;
    }

    .hidden {
      display: none !important;
    }

    .modal-content {
      background: #f8f0ff;
      padding: 20px;
      border-radius: 12px;
      width: 450px;
      max-height: 80vh;
      overflow-y: auto;
      color: #4b0082;
      box-shadow: 0 0 10px #dabfff;
      position: relative;
    }

    .modal-content h3, .modal-content h4 {
      margin-top: 0;
      margin-bottom: 15px;
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

    .modal-content button:hover {
      background: #9454ff;
    }

    .close {
      position: absolute;
      top: 5px;
      right: 15px;
      font-size: 22px;
      cursor: pointer;
      color: #4b0082;
    }

    .close:hover {
      color: #8b6edb;
    }

    /* Success Modal */
    .success-modal {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-color: rgba(75, 0, 130, 0.4);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 1001;
    }

    .success-modal-content {
      background: #f0fff4;
      padding: 30px;
      border-radius: 12px;
      width: 400px;
      text-align: center;
      color: #2d5016;
      box-shadow: 0 0 20px rgba(0, 128, 0, 0.3);
      border: 2px solid #90ee90;
    }

    .success-modal h3 {
      color: #228b22;
      margin-bottom: 20px;
    }

    .success-modal button {
      background: #32cd32;
      border: none;
      padding: 12px 20px;
      color: white;
      font-weight: bold;
      border-radius: 6px;
      cursor: pointer;
      margin: 5px;
    }

    .success-modal button:hover {
      background: #228b22;
    }
  </style>
</head>

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

  <!-- Main Content -->
  <div class="main">
    <h2 class="title">Billing Page</h2>

    <!-- Search Box -->
    <div class="search-box">
      <form method="get" action="SearchCustomer">
        <input type="text" name="accountNumber" placeholder="Enter Account Number" />
        <input type="text" name="name" placeholder="Or Enter Customer Name" />
        <button type="submit">Search Customer</button>
      </form>
    </div>

    <!-- Customer Details -->
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
      <!-- Item List -->
      <div class="item-list">
        <% if (items != null && !items.isEmpty()) {
             for (Item item : items) { %>
          <div class="item" data-item-id="<%= item.getId() %>">
            <h4 class="item-name"><%= item.getName() %></h4>
            <p class="item-price">Rs. <%= item.getPrice() %></p>
            <button class="add-to-cart">Add to Cart</button>
          </div>
        <% }
           } else { %>
          <p>No items found.</p>
        <% } %>
      </div>
    </div>

    <!-- Cart Panel -->
    <div class="cart">
      <h3>Shopping Cart</h3>
      <div class="cart-items"></div>

      <hr style="margin: 20px 0; border-color: #d2bfff;" />

      <div class="cart-item" style="font-weight: bold;">
        <span>Total</span>
        <span id="total-price">Rs. 0</span>
      </div>

      <button class="checkout" id="checkout-btn" disabled>Checkout</button>
    </div>

    <!-- Order Form (Hidden) -->
    <form id="order-form" action="PlaceOrderServlet" method="post" style="display: none;">
      <% if (customer != null) { %>
        <input type="hidden" name="customerId" value="<%= customer.getId() %>">
      <% } %>
      <input type="hidden" name="itemsJson" id="items-json">
      <input type="hidden" name="total" id="total-input">
    </form>

    <!-- Order Confirmation Modal -->
    <div class="modal hidden" id="order-modal">
      <div class="modal-content">
        <span class="close" id="close-modal">&times;</span>
        <h3>Order Summary</h3>
        <div id="modal-summary"></div>

        <hr style="margin: 20px 0; border-color: #d2bfff;" />

        <h4>Customer Details</h4>
        <% if (customer != null) { %>
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

          <button id="confirm-order" type="button">Confirm Order</button>
        <% } else { %>
          <p style="color:red;">❌ Customer data not found. Please search for a customer first.</p>
        <% } %>
      </div>
    </div>

    <!-- Success Modal -->
    <div class="success-modal hidden" id="success-modal">
      <div class="success-modal-content">
        <h3>✅ Order Placed Successfully!</h3>
        <p>Your order has been confirmed and processed.</p>
        <p><strong>Order ID:</strong> <span id="order-id-display"></span></p>

        <div style="margin-top: 20px;">
          <button id="download-pdf-btn">📄 Download PDF Bill</button>
          <button id="new-order-btn">🛒 New Order</button>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const cart = {};
    let total = 0;
    let lastOrderData = null; // Store order data for PDF generation

    const cartItemsContainer = document.querySelector('.cart-items');
    const totalPriceSpan = document.getElementById('total-price');
    const modal = document.getElementById('order-modal');
    const modalClose = document.getElementById('close-modal');
    const checkoutBtn = document.getElementById('checkout-btn');
    const confirmOrderBtn = document.getElementById('confirm-order');
    const modalSummary = document.getElementById('modal-summary');
    const orderForm = document.getElementById('order-form');
    const successModal = document.getElementById('success-modal');
    const downloadPdfBtn = document.getElementById('download-pdf-btn');
    const newOrderBtn = document.getElementById('new-order-btn');

    // Ensure modals are hidden on page load
    if (successModal) {
        successModal.classList.add('hidden');
    }
    if (modal) {
        modal.classList.add('hidden');
    }

    // Add to Cart functionality
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', () => {
            const itemElement = button.closest('.item');
            const itemId = itemElement.dataset.itemId;
            const itemName = itemElement.querySelector('.item-name').textContent.trim();
            const itemPrice = parseFloat(itemElement.querySelector('.item-price').textContent.replace('Rs. ', ''));

            if (cart[itemId]) {
                cart[itemId].quantity += 1;
            } else {
                cart[itemId] = {
                    name: itemName,
                    price: itemPrice,
                    quantity: 1
                };
            }

            updateCartDisplay();
        });
    });

    // Update Cart Display
    function updateCartDisplay() {
        cartItemsContainer.innerHTML = '';
        total = 0;

        // Check if cart is empty
        if (Object.keys(cart).length === 0) {
            checkoutBtn.disabled = true;
            totalPriceSpan.textContent = 'Rs. 0';
            return;
        }

        // Enable checkout button
        checkoutBtn.disabled = false;

        // Display cart items
        for (const [itemId, item] of Object.entries(cart)) {
            const itemTotal = item.price * item.quantity;
            total += itemTotal;

            const div = document.createElement('div');
            div.className = 'cart-item';
            div.innerHTML = `
                <div>
                    <div style="font-weight: bold;">${item.name}</div>
                    <div style="font-size: 12px;">Rs. ${item.price} each</div>
                </div>
                <div class="quantity-controls">
                    <button class="decrease" data-item-id="${itemId}">−</button>
                    <span class="quantity">${item.quantity}</span>
                    <button class="increase" data-item-id="${itemId}">+</button>
                </div>
                <div style="font-weight: bold;">Rs. ${itemTotal}</div>
            `;

            cartItemsContainer.appendChild(div);
        }

        totalPriceSpan.textContent = `Rs. ${total}`;
        attachQuantityButtonListeners();
    }

    // Attach quantity control listeners
    function attachQuantityButtonListeners() {
        document.querySelectorAll('.increase').forEach(btn => {
            btn.addEventListener('click', () => {
                const itemId = btn.dataset.itemId;
                cart[itemId].quantity++;
                updateCartDisplay();
            });
        });

        document.querySelectorAll('.decrease').forEach(btn => {
            btn.addEventListener('click', () => {
                const itemId = btn.dataset.itemId;
                if (cart[itemId].quantity > 1) {
                    cart[itemId].quantity--;
                } else {
                    delete cart[itemId];
                }
                updateCartDisplay();
            });
        });
    }

    // Checkout: Show Modal
    checkoutBtn.addEventListener('click', () => {
        if (Object.keys(cart).length === 0) {
            alert('Cart is empty!');
            return;
        }

        <% if (customer == null) { %>
            alert('Please search and select a customer first!');
            return;
        <% } %>

        // Populate modal summary
        modalSummary.innerHTML = '';

        for (const [itemId, item] of Object.entries(cart)) {
            const line = document.createElement('p');
            line.innerHTML = `<strong>${item.name}</strong> x ${item.quantity} = Rs. ${item.price * item.quantity}`;
            modalSummary.appendChild(line);
        }

        const totalLine = document.createElement('p');
        totalLine.innerHTML = `<strong style="font-size: 18px;">Total: Rs. ${total}</strong>`;
        modalSummary.appendChild(totalLine);

        modal.classList.remove('hidden');
    });

    // Close Modal
    modalClose.addEventListener('click', () => {
        modal.classList.add('hidden');
    });

    // Confirm Order
    if (confirmOrderBtn) {
        confirmOrderBtn.addEventListener('click', () => {
            // Validate cart is not empty
            if (Object.keys(cart).length === 0) {
                alert('Cart is empty!');
                return;
            }

            confirmOrderBtn.disabled = true;
            confirmOrderBtn.textContent = 'Processing...';

            // Store order data for PDF generation
            lastOrderData = {
                cart: {...cart},
                total: total,
                customer: {
                    <% if (customer != null) { %>
                    name: '<%= customer.getName() %>',
                    accountNo: '<%= customer.getaccNo() %>',
                    address: '<%= customer.getAddress() %>',
                    phone: '<%= customer.getPhone() %>',
                    email: '<%= customer.getEmail() %>'
                    <% } %>
                },
                orderDate: new Date(),
                orderId: 'ORD-' + Date.now()
            };

            // Generate and download PDF immediately
            generatePDFBill(lastOrderData);

            // Prepare form data for server submission
            const itemsJson = JSON.stringify(cart);
            document.getElementById('items-json').value = itemsJson;
            document.getElementById('total-input').value = total;


             orderForm.submit();

            // For now, simulate order processing
            setTimeout(() => {
                // Hide order modal
                modal.classList.add('hidden');

                // Show success modal
                document.getElementById('order-id-display').textContent = lastOrderData.orderId;
                successModal.classList.remove('hidden');

                // Reset form state
                confirmOrderBtn.disabled = false;
                confirmOrderBtn.textContent = 'Confirm Order';

                // Clear cart after successful order
                Object.keys(cart).forEach(key => delete cart[key]);
                updateCartDisplay();
            }, 1000);
        });
    }

    // Download PDF functionality
    downloadPdfBtn.addEventListener('click', () => {
        if (!lastOrderData) {
            alert('No order data available');
            return;
        }

        generatePDFBill(lastOrderData);
    });

    // New Order functionality
    newOrderBtn.addEventListener('click', () => {
        // Clear cart (already cleared after successful order)
        Object.keys(cart).forEach(key => delete cart[key]);
        updateCartDisplay();

        // Hide success modal
        successModal.classList.add('hidden');

        // Reset order data
        lastOrderData = null;

        // Optionally reload the page to reset everything
        // window.location.reload();
    });

    // PDF Generation Function
    function generatePDFBill(orderData) {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        // Set up colors
        const primaryColor = [160, 132, 232]; // #a084e8
        const secondaryColor = [92, 74, 114]; // #5c4a72
        const lightColor = [243, 232, 255]; // #f3e8ff

        // Header
        doc.setFillColor(...primaryColor);
        doc.rect(0, 0, 210, 30, 'F');

        doc.setTextColor(255, 255, 255);
        doc.setFontSize(24);
        doc.setFont('helvetica', 'bold');
        doc.text('PAHANA EDU', 105, 20, { align: 'center' });

        doc.setFontSize(12);
        doc.setFont('helvetica', 'normal');
        doc.text('Educational Bill & Invoice', 105, 26, { align: 'center' });

        // Reset text color
        doc.setTextColor(0, 0, 0);

        // Bill Info Section
        doc.setFontSize(16);
        doc.setFont('helvetica', 'bold');
        doc.text('BILL DETAILS', 20, 45);

        doc.setFontSize(10);
        doc.setFont('helvetica', 'normal');
        doc.text(`Bill ID: ${orderData.orderId}`, 20, 55);
        doc.text(`Date: ${orderData.orderDate.toLocaleDateString()}`, 20, 62);
        doc.text(`Time: ${orderData.orderDate.toLocaleTimeString()}`, 20, 69);

        // Customer Info Section
        doc.setFontSize(16);
        doc.setFont('helvetica', 'bold');
        doc.text('CUSTOMER INFORMATION', 110, 45);

        doc.setFontSize(10);
        doc.setFont('helvetica', 'normal');
        doc.text(`Name: ${orderData.customer.name}`, 110, 55);
        doc.text(`Account No: ${orderData.customer.accountNo}`, 110, 62);
        doc.text(`Phone: ${orderData.customer.phone}`, 110, 69);
        doc.text(`Email: ${orderData.customer.email}`, 110, 76);

        // Address (multi-line handling)
        const addressLines = doc.splitTextToSize(`Address: ${orderData.customer.address}`, 80);
        doc.text(addressLines, 110, 83);

        // Items Table Header
        let yPos = 100;
        doc.setFillColor(...lightColor);
        doc.rect(20, yPos - 5, 170, 10, 'F');

        doc.setFontSize(12);
        doc.setFont('helvetica', 'bold');
        doc.text('ITEM DETAILS', 105, yPos, { align: 'center' });

        yPos += 15;

        // Table headers
        doc.setFontSize(10);
        doc.setFont('helvetica', 'bold');
        doc.text('Item Name', 25, yPos);
        doc.text('Qty', 90, yPos);
        doc.text('Unit Price', 110, yPos);
        doc.text('Total', 150, yPos);

        // Draw line under headers
        doc.setDrawColor(...secondaryColor);
        doc.line(20, yPos + 2, 190, yPos + 2);

        yPos += 10;

        // Items
        doc.setFont('helvetica', 'normal');
        let grandTotal = 0;

        for (const [itemId, item] of Object.entries(orderData.cart)) {
            const itemTotal = item.price * item.quantity;
            grandTotal += itemTotal;

            doc.text(item.name, 25, yPos);
            doc.text(item.quantity.toString(), 90, yPos);
            doc.text(`Rs. ${item.price}`, 110, yPos);
            doc.text(`Rs. ${itemTotal}`, 150, yPos);

            yPos += 8;
        }

        // Total Section
        yPos += 10;
        doc.setDrawColor(...primaryColor);
        doc.line(120, yPos, 190, yPos);

        yPos += 10;
        doc.setFontSize(14);
        doc.setFont('helvetica', 'bold');
        doc.text(`GRAND TOTAL: Rs. ${grandTotal}`, 150, yPos);

        // Footer
        yPos += 30;
        doc.setFontSize(10);
        doc.setFont('helvetica', 'italic');
        doc.setTextColor(100, 100, 100);
        doc.text('Thank you for choosing Pahana Edu!', 105, yPos, { align: 'center' });
        doc.text('For any queries, please contact our support team.', 105, yPos + 7, { align: 'center' });

        // Add a border around the entire document
        doc.setDrawColor(...primaryColor);
        doc.setLineWidth(0.5);
        doc.rect(10, 10, 190, 270);

        // Save the PDF
        const fileName = `Pahana_Edu_Bill_${orderData.orderId}.pdf`;
        doc.save(fileName);
    }

    // Close modal when clicking outside
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            modal.classList.add('hidden');
        }
    });

    // Close success modal when clicking outside
    successModal.addEventListener('click', (e) => {
        if (e.target === successModal) {
            successModal.classList.add('hidden');
        }
    });
});
</script>

</body>
</html>