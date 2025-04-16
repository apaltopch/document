from PyQt6 import QtCore, QtGui, QtWidgets


class Ui_AdminFrom(object):
    def setupUi(self, AdminFrom):
        AdminFrom.setObjectName("AdminFrom")
        AdminFrom.resize(740, 547)
        AdminFrom.setStyleSheet("background-color: rgb(255, 255, 255); color:black")
        self.listWidget = QtWidgets.QListWidget(parent=AdminFrom)
        self.listWidget.setGeometry(QtCore.QRect(20, 20, 701, 421))
        self.listWidget.setStyleSheet("background-color: rgb(248, 124, 0);")
        self.listWidget.setObjectName("listWidget")
        self.widget = QtWidgets.QWidget(parent=AdminFrom)
        self.widget.setGeometry(QtCore.QRect(20, 450, 493, 30))
        self.widget.setObjectName("widget")
        self.horizontalLayout = QtWidgets.QHBoxLayout(self.widget)
        self.horizontalLayout.setContentsMargins(0, 0, 0, 0)
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.add_user_btn = QtWidgets.QPushButton(parent=self.widget)
        self.add_user_btn.setStyleSheet("background-color: rgb(0, 170, 0);\n"
"color: rgb(255, 255, 255);")
        self.add_user_btn.setObjectName("add_user_btn")
        self.horizontalLayout.addWidget(self.add_user_btn)
        self.info_docs_list_btn = QtWidgets.QPushButton(parent=self.widget)
        self.info_docs_list_btn.setStyleSheet("background-color: rgb(0, 170, 0);\n"
"color: rgb(255, 255, 255);")
        self.info_docs_list_btn.setObjectName("info_docs_list_btn")
        self.horizontalLayout.addWidget(self.info_docs_list_btn)
        self.show_request_btn = QtWidgets.QPushButton(parent=self.widget)
        self.show_request_btn.setStyleSheet("background-color: rgb(0, 170, 0);\n"
"color: rgb(255, 255, 255);")
        self.show_request_btn.setObjectName("show_request_btn")
        self.horizontalLayout.addWidget(self.show_request_btn)

        self.retranslateUi(AdminFrom)
        QtCore.QMetaObject.connectSlotsByName(AdminFrom)

    def retranslateUi(self, AdminFrom):
        _translate = QtCore.QCoreApplication.translate
        AdminFrom.setWindowTitle(_translate("AdminFrom", "Администратор"))
        self.add_user_btn.setText(_translate("AdminFrom", "Добавить пользователя"))
        self.info_docs_list_btn.setText(_translate("AdminFrom", "Регистрация дел, документов, описей"))
        self.show_request_btn.setText(_translate("AdminFrom", "Заявки"))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    AdminFrom = QtWidgets.QWidget()
    ui = Ui_AdminFrom()
    ui.setupUi(AdminFrom)
    AdminFrom.show()
    sys.exit(app.exec())
