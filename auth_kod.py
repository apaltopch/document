import MySQLdb
from PyQt6.QtWidgets import QApplication, QWidget, QMessageBox, QMainWindow
import MySQLdb as mdb
import sys
from autorization import Ui_Form
from admin_window_code import AdminMain
from user_window_code import User_Window



# try:
#     connect = mdb.connect("127.0.0.1", "root", "root", "documents_system")
#     cursor = connect.cursor()
# except mdb.Error as e:
#     QMessageBox.critical(None, 'Ошибка', f'Ошибка запуска {e}')


class Auth(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_Form()
        self.ui.setupUi(self)

    #
    #     self.ui.pushButton_autorization.clicked.connect(self.login)
    #
    # def login(self):
    #     username = self.ui.lineEdit_login.text()
    #     password = self.ui.lineEdit_password.text()
    #
    #     if not username or not password:
    #         QMessageBox.warning(self,"Ошибка", "Заполните все поля!")
    #
    #     try:
    #             cursor.execute("""select id, username, passw, email,role from users
    #             where username = %s and passw = %s""",(username, password, ))
    #             user = cursor.fetchone()
    #             connect.commit()
    #
    #             if user:
    #                 role = user[4]
    #
    #                 if role == "admin":
    #                     QMessageBox.information(self,"Успех", f"Добро пожаловать в систему: {user[1]}")
    #                     self.open_admin_window()
    #                 elif role == "user":
    #                     QMessageBox.information(self, "Успех", f"Добро пожаловать в систему: {user[1]}")
    #                     self.open_user_window()
    #             else:
    #                 QMessageBox.information(self,"Ошибка","Неверный логин")
    #     except MySQLdb.Error as e:
    #         (QMessageBox.critical(self, "Ошибка", f"Ошибка в бд: {e}"))
    #
    # def open_admin_window(self):
    #     self.hide()
    #     self.admin_window = AdminMain(self)
    #     self.admin_window.show()
    #
    # def open_user_window(self):
    #     self.hide()
    #     self.user_window = User_Window(self)
    #     self.user_window.show()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = Auth()
    window.show()
    sys.exit(app.exec())
