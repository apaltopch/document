import MySQLdb
from PyQt6.QtWidgets import QApplication, QMainWindow, QWidget, QMessageBox, QListWidgetItem, QDialog
from admin_form import *
import sys
import MySQLdb as mdb
from request import Ui_UpdateReqForm



try:
    connect = mdb.connect('localhost', 'root', 'root', 'tech_service2')
except mdb.Error as e:
    QMessageBox.critical(None, 'Ошибка', f'Ошибка соединения {e}')


class EditRequest(QDialog):
    def __init__(self, main_window, request_data):
        super().__init__()
        self.ui = Ui_UpdateReqForm()
        self.ui.setupUi(self)

        self.main_window = main_window
        self.request_id = request_data[0]
        self.load_status()
        self.load_priority()
        self.load_type()
        self.ui.num_req_label_2.setText(str(request_data[1]))
        self.ui.date_req_label_4.setText(str(request_data[2]))
        self.ui.update_pushButton.clicked.connect(self.save_changes)
        self.ui.back_pushButton_2.clicked.connect(self.back)
        self.ui.delete_pushButton_2.clicked.connect(self.delete_req)

        status_index = self.ui.status_comboBox.findText(request_data[3])
        if status_index >= 0:
            self.ui.status_comboBox.setCurrentIndex(status_index)

        priority_index = self.ui.priority_comboBox_2.findText(request_data[4])
        if priority_index >= 0:
            self.ui.priority_comboBox_2.setCurrentIndex(priority_index)

        type_index = self.ui.type_req_comboBox_3.findText(request_data[5])
        if type_index >= 0:
            self.ui.type_req_comboBox_3.setCurrentIndex(type_index)

    def load_status(self):
        '''Вывод статусов в комбо бокс'''
        try:
            with connect.cursor() as cur:
                cur.execute("""select id, status from requests""")
                statuses = cur.fetchall()

                for status in statuses:
                    self.ui.status_comboBox.addItem(status[1], status[0])

        except Exception as e:
            QMessageBox.critical(self, 'ошибка', f'ошибка статусов {e}')

    def load_priority(self):
        try:
            with connect.cursor() as cur:
                cur.execute("""select id, priority from requests""")
                prs = cur.fetchall()

                for pr in prs:
                    self.ui.priority_comboBox_2.addItem(pr[1], pr[0])

        except Exception as e:
            QMessageBox.critical(self, 'ошибка', f'ошибка приоритетов {e}')

    def load_type(self):
        try:
            with connect.cursor() as cur:
                cur.execute("""select id, name from type_requests""")
                types = cur.fetchall()

                for type in types:
                    self.ui.type_req_comboBox_3.addItem(type[1], type[0])

        except Exception as e:
            QMessageBox.critical(self, 'ошибка', f'ошибка статусов {e}')

    def delete_req(self):
        '''Удаление заявки с подтверждением'''
        # Создаем диалоговое окно подтверждения
        reply = QMessageBox.question(
            self,
            'Подтверждение удаления',
            'Вы точно хотите удалить эту заявку?',
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No,
            QMessageBox.StandardButton.No
        )

        # Если пользователь подтвердил удаление
        if reply == QMessageBox.StandardButton.Yes:
            try:
                with connect.cursor() as cur:
                    # Удаляем связанные сообщения сначала
                    cur.execute("DELETE FROM messages WHERE id_requests = %s", (self.request_id,))
                    # Затем удаляем саму заявку
                    cur.execute("DELETE FROM requests WHERE id = %s", (self.request_id,))
                    connect.commit()

                    QMessageBox.information(self, 'Успех', 'Заявка успешно удалена')

                    # Обновляем список заявок в главном окне
                    self.main_window.show_request()

            except Exception as e:
                QMessageBox.critical(self, 'Ошибка', f'Ошибка при удалении заявки: {e}')
                print(f"Ошибка удаления: {e}")

    def save_changes(self):
        try:
            status = self.ui.status_comboBox.currentData()
            priority = self.ui.priority_comboBox_2.currentData()
            type_status = self.ui.type_req_comboBox_3.currentData()

            if not all([status, priority, type_status]):
                QMessageBox.warning(self, 'Внимание', 'Заполните все поля!')
                return

            with connect.cursor() as cur:
                cur.execute("""update requests r set 
                status = %s, priority = %s, 
                type_id = %s where id = %s""", (status, priority, type_status, self.request_id))

                connect.commit()
                QMessageBox.information(self, 'Успех', 'Данные успешно изменены')
                self.main_window.show_request()

        except Exception as e:
            QMessageBox.critical(self, 'Ошибка', f'Ошибка при сохранении {e}')

    def back(self):
        self.hide()


class AdminMain(QMainWindow):
    def __init__(self, main_window):
        super().__init__()
        self.ui = Ui_AdminFrom()
        self.ui.setupUi(self)

        self.main_window = main_window

        self.ui.add_user_btn.clicked.connect(self.add_user)
        self.ui.show_request_btn.clicked.connect(self.show_request)
        self.ui.listWidget.itemClicked.connect(self.on_item_clicked)
        self.ui.info_docs_list_btn.clicked.connect(self.open_doc_win)
        self.show_users()

    def show_users(self):
        try:
            self.ui.listWidget.clear()
            with connect.cursor() as cur:
                cur.execute("""select users.name,users.surname,users.email,users.phone,users.role 
                from users""")
                users = cur.fetchall()

                if not users:
                    QMessageBox.information(self, "Информация", "Нет данных о пользователях")
                    return

                for user in users:
                    surname, name, email, phone, role = user

                    item_text = (
                        f"Имя:{name} | "
                        f"Фамилия: {surname}\n"
                        f"Почта: {email}\n"
                        f"Телефон: {phone}\n"
                        f"Роль:{role}\n"
                        "-----------------------"
                    )

                    item = QListWidgetItem(item_text)
                    self.ui.listWidget.addItem(item)

        except MySQLdb.Error as e:
            QMessageBox.critical(self, "ошибка", f"ошибка бд: {str(e)}")

    def show_request(self):
        try:
            self.ui.listWidget.clear()
            with connect.cursor() as cur:
                cur.execute("""select r.number, r.created_at, r.status, r.priority, type_requests.name, client.name 
                from requests r
                join type_requests on r.type_id = type_requests.id
                join client on r.id_client = client.id""")

                requests = cur.fetchall()

                if not requests:
                    QMessageBox.information(self, 'Информация', 'Нет данных о заявках')

                for request in requests:
                    number, created_at, status, priority, type_request, client = request

                    item_text = (
                        f"Номер заявки: {number} | Дата создания: {created_at} \n"
                        f"Статус: {status} | Приоритет: {priority} | Тип: {type_request}\n"
                        f"ФИО заявителя: {client} \n"
                        "---------------------------"
                    )

                    item = QListWidgetItem(item_text)
                    self.ui.listWidget.addItem(item)
        except Exception as e:
            QMessageBox.critical(self, 'Ошибка', f"Ошибка вывода данных {e}")

    def get_request_data(self, number):
        try:
            with connect.cursor() as cur:
                cur.execute("""select r.id, r.number, r.created_at, r.status, r.priority, type_requests.name, client.name 
                from requests r
                join type_requests on r.type_id = type_requests.id
                join client on r.id_client = client.id
                where r.number = %s""", (number,))

                return cur.fetchone()

        except mdb.Error as e:
            QMessageBox.critical(self, 'Ошибка', f'Ошибка получения данных {e}')
            return None

    def on_item_clicked(self, item):
        try:
            text = item.text()

            number = None
            for line in text.split('\n'):
                if line.startswith("Номер заявки:"):
                    number = line.split(':')[1].strip()
                    break

            if number:
                request_data = self.get_request_data(number)
                if request_data:
                    self.change_req = EditRequest(self, request_data)
                    self.change_req.show()

        except Exception as e:
            QMessageBox.warning(self, 'Ошибка', f'Ошибка какашка {e}')

    def add_user(self):
        from add_user_code import AddUser
        self.hide()
        self.addWindow = AddUser(self)
        self.addWindow.show()
