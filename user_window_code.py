from PyQt6.QtWidgets import QMessageBox, QMainWindow, QTableWidgetItem
import MySQLdb as mdb
from users_interface import Users_MainWindow
from PyQt6.QtCore import Qt

try:
    connect = mdb.connect('127.0.0.1', 'root', 'root', 'tech_service2')
    cur = connect.cursor()
except mdb.Error as e:
    QMessageBox.critical(None, 'Ошибка', f'Ошибка соединения {e}')


class User_Window(QMainWindow):
    def __init__(self,main_window):
        super().__init__()

        self.ui = Users_MainWindow()
        self.ui.setupUi(self)

        self.main_window = main_window
        self.load_cases()
        #self.check_completnes()

    def load_cases(self):
        '''загрузка электронных дел в таблицу'''
        try:
            cur.execute("""select c.id, c.title, d.name, c.completeness_checked, a.name
               from cases c
               left join departments d on c.id_department = d.id 
               left join archive a on c.id_archive = a.id""")

            res = cur.fetchall()

            self.ui.tableReception.setRowCount(0)
            self.ui.tableReception.setColumnCount(5)
            self.ui.tableReception.setHorizontalHeaderLabels(["ID","Название дела","Подразделение","Комплектность","Архив"])

            for row_data in res:
                row = self.ui.tableReception.rowCount()
                self.ui.tableReception.insertRow(row)

                for col in range(5):
                    item = QTableWidgetItem(str(row_data[col]))
                    item.setFlags(Qt.ItemFlag.ItemIsEnabled | Qt.ItemFlag.ItemIsSelectable)
                    self.ui.tableReception.setItem(row, col, item)

            # Сортировка в PyQt6
            self.ui.tableReception.setSortingEnabled(True)
            self.ui.tableReception.sortByColumn(0, Qt.SortOrder.AscendingOrder)
        except Exception as e:
            QMessageBox.critical(self, 'Ошибка', f'Ошибка запроса дел {e}')






