from PyQt6.QtWidgets import QApplication, QMainWindow, QWidget, QMessageBox
import sys
import MySQLdb as mdb
from add_user import *
from adminMain import AdminMain

try:
    connect = mdb.connect('127.0.0.1', 'root', 'root', 'tech_service2')
except mdb.Error as e:
    QMessageBox.critical(None, 'Ошибка', f'Ошибка соединения {e}')


class AddUser(QMainWindow):
    def __init__(self, main_window):
        super().__init__()
        self.ui = Ui_AddForm()
        self.ui.setupUi(self)
        self.main_window = main_window

        self.ui.back_pushButton_2.clicked.connect(self.back)
        self.ui.add_pushButton.clicked.connect(self.add_user)

        self.ui.admin_checkBox.toggled.connect(lambda: self.on_checkbox_toggled(self.ui.admin_checkBox))
        self.ui.emp_checkBox.toggled.connect(lambda: self.on_checkbox_toggled(self.ui.emp_checkBox))

    def add_user(self):
        try:
            surname = self.ui.surname_lineEdit.text()
            name = self.ui.name_lineEdit.text()
            email = self.ui.email_lineEdit_3.text()
            phone = self.ui.phone_lineEdit_4.text()
            role = ""

            if self.ui.admin_checkBox.isChecked():
                role = self.ui.admin_checkBox.text()
            elif self.ui.emp_checkBox.isChecked():
                role = self.ui.emp_checkBox.text()


            if not all([surname, name, email, phone]):
                QMessageBox.warning(self, 'Ошибка', 'Заполните все поля!')
                return

            if not role:
                QMessageBox.warning(self, 'Ошибка', 'Выберите роль пользователя!')
                return
            with connect.cursor() as cur:
                cur.execute("""INSERT INTO users (surname, name, email, phone, role) 
                               VALUES (%s, %s, %s, %s, %s)""",
                            (surname, name, email, phone, role))
                connect.commit()
                QMessageBox.information(self, 'Успех', f'Пользователь добавлен')

        except mdb.Error as e:
            QMessageBox.critical(self, 'Ошибка', f'Ошибка добавления {e}')

    def on_checkbox_toggled(self, checkbox):
        '''обработчик изменения состояния чекбоксов'''
        if checkbox.isChecked():
            if checkbox == self.ui.admin_checkBox:
                self.ui.emp_checkBox.setChecked(False)
            else:
                self.ui.admin_checkBox.setChecked(False)

    def back(self):
        self.close()
        self.main_window = AdminMain(self)
        self.main_window.show()
