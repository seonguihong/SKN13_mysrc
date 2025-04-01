#mypackage/calculator.py

__version__ = 0.1 #버전을 변수로 저장

def plus(num1,num2):
    return num1 + num2

def mius(num1,num2):
    return num1 - num2

def multiply(num1,num2):
    return num1 * num2

def divide(num1,num2):
    return num1 / num2

if __name__ == '__main__':
    print(">>>>>name<<<<<", __name__)