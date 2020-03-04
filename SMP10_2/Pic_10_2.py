#!/usr/bin/python3
# -*- coding: utf-8 -*-


import sys
from PyQt5.QtWidgets import QMainWindow, QPushButton, QApplication
import serial

class Example(QMainWindow):

    def __init__(self):
        super().__init__()

        self.initUI()


    def initUI(self):      
        btn0 = QPushButton("Button 0", self)
        btn0.move(30, 50)

        btn1 = QPushButton("Button 1", self)
        btn1.move(150, 50)

        btn2 = QPushButton("Button 2", self)
        btn2.move(270, 50)

        btn3 = QPushButton("Button 3", self)
        btn3.move(390, 50)

        # クリックされたらbuttonClickedの呼び出し
        btn0.clicked.connect(self.buttonClicked)
        btn1.clicked.connect(self.buttonClicked)            
        btn2.clicked.connect(self.buttonClicked)
        btn3.clicked.connect(self.buttonClicked)

        self.statusBar()

        self.setGeometry(300, 300, 510, 150)
        self.setWindowTitle('Event sender')
        self.show()


    def buttonClicked(self):

        # ステータスバーへメッセージの表示
        sender = self.sender()
        if(sender.text() == "Button 0"):
            self.statusBar().showMessage('Button 0 was pressed')
            ser.write(b'0')
        elif(sender.text() == "Button 1"):
            self.statusBar().showMessage('Button 1 was pressed')
            ser.write(b'1')
        elif(sender.text() == "Button 2"):
            self.statusBar().showMessage('Button 2 was pressed')
            ser.write(b'2')            
        elif(sender.text() == "Button 3"):
            self.statusBar().showMessage('Button 3 was pressed') 
            ser.write(b'3')           

if __name__ == '__main__':
    ser = serial.Serial('COM3',9600,timeout=1)
    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())
    ser.close()