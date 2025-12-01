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

if __name__ =='__main__':
    app.run(debug=True)