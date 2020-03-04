#!/usr/bin/python3
# -*- coding: utf-8 -*-
import serial
import sys
from PyQt5.QtWidgets import (QWidget, QLabel, 
    QLineEdit, QPushButton, QApplication)
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtCore import QCoreApplication

ser = serial.Serial('COM5',9600)

class Example(QWidget):

    def __init__(self):
        super().__init__()

        self.initUI()


    def initUI(self):      

        # ラベルオブジェクト作成
        self.lbl = QLabel(self)

        self.addText = 'A'
        self.cnt = 0

        btn1 = QPushButton("Button 1", self)
        btn1.clicked.connect(self.finish)
        btn1.move(60,100)

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.onChanged)
        self.timer.start(100)#一秒間隔で更新

        self.setGeometry(300, 300, 280, 170)
        self.setWindowTitle('QLineEdit')
        self.show()

    def finish(self):
        ser.close()
        sys.exit()
    
    def onChanged(self):
        # ラベルに入力されたテキストを挿入
        recv = ser.read()
        if(recv == b'A'):
            MyCnt = self.cnt
            MyText = self.addText
            while(MyCnt > 0):
                MyText += self.addText
                MyCnt = MyCnt - 1
            self.lbl.setText(MyText)
            # 入力されたテキストによって、ラベルの長さを調整
            self.cnt += 1
            self.lbl.adjustSize()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())