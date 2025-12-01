
@app.route('/menu')
def menu():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT ItemName,category,price FROM Menu")
    menu = cursor.fetchall()
    conn.close()
    return render_template('Menu.html', menu=menu)

