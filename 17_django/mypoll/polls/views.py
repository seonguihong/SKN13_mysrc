# polls/views.py - view들을 구현
# view: 하나의 사용자 요청을 처리하는 함수

from django.shortcuts import render
from django.http import HttpResponse
from datetime import datetime 

def welcome_poll_old(request):
    # view 함수 -> 1개 이상의 파라미터를 선언. (1개 필수-HttpRequest객체를 받는다.)
    now = datetime.now().strftime("%Y년 %m월 %d일 %H시 %M분 %S초") #실행시점의 일시
    res_html = f"""<!doctype html>
<html>
    <head>
        <title>Welcome Poll</title>
    </head>
    <body>
        <h1>설문조사 APP</h1>
        현재시간: {now}
    </body>
</html>
"""
    return HttpResponse(res_html)

def welcome_poll(request):
    now = datetime.now().strftime("%Y년 %m월 %d일 %H시 %M분 %S초")
    # template 을 이용해서 응답 페이지를 생성.
    response = render(
        request,              # HttpRequest
        "polls/welcome.html", # template파일의 경로(app_directory/templates 이후 경로)
        {"now": now, "name":"홍길동"} 
        # view가 template에 전달할 값들을 dictionary에 name-value 로 묶어서 전달.
        #    -> context value라고 한다.
    )
    # response: HttpResponse(polls/welcome.html 처리 내용)
    print("=============", type(response))
    return response
# http://127.0.0.1:8000/polls/welcome