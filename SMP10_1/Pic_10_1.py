#coding:utf-8

#シリアル通信で文字をArduino側に送信
#aが押されたら通信を中止するプログラム

import serial   #モジュール名はpyserialだが, importする際はserialである
import sys
from PyQt5.QtWidgets import (QWidget, QLabel,QLineEdit, QApplication)
import serial

class Example(QWidget):
    
    def __init__(self):
        super().__init__()

        self.initUI()


    def initUI(self):      

        # ラベルオブジェクト作成
        self.lbl = QLabel(self)
        # QLineEditオブジェクト作成
        qle = QLineEdit(self)

        qle.move(60, 100)
        self.lbl.move(60, 40)

        # qleに文字が入力されたら、onChanged関数の呼び出し
        qle.textChanged[str].connect(self.onChanged)

        self.setGeometry(300, 300, 280, 170)
        self.setWindowTitle('QLineEdit')
        self.show()


    def onChanged(self, text):
        ser.write(text.encode())
        # ラベルに入力されたテキストを挿入
        self.lbl.setText(text)
        # 入力されたテキストによって、ラベルの長さを調整
        self.lbl.adjustSize()        


if __name__ == '__main__':
    ser = serial.Serial('COM3',9600,timeout=1)
    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())
    ser.close()