from flask import Flask, render_template, request, redirect
from db import get_connection

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/menu')
def menu():
    conn = get_connection()
    if conn is None:
        return "Failed to connect with server!"
    cursor = conn.cursor()
    cursor.execute("SELECT ItemName,category,price FROM Menu")
    menu = cursor.fetchall()
    conn.close()
    return render_template('Menu.html', menu=menu)

@app.route('/customers')
def customers():
    conn = get_connection()
    if conn is None:
        return "Failed to connect with server!"
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM customers")
    customers = cursor.fetchall()
    conn.close()
    return render_template('customers.html', customers=customers)

@app.route('/add_customer', methods=['GET', 'POST'])
def add_customer():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']

        with get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute(
                "INSERT INTO customers (name,email,phone) VALUES (?, ?, ?)",
                (name, email, phone)
            )
            conn.commit()

        return redirect('/customers')
    else:
        return render_template('add_customer.html')

if __name__ =='__main__':
    app.run(debug=True)