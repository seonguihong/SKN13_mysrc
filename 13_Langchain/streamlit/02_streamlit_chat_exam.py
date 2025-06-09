import streamlit as st
from langchain.prompts import ChatPromptTemplate
from langchain_openai import ChatOpenAI


if "messages" not in st.session_state:
    st.session_state["messages"] = []


st.title("Chatbot 위젯 튜토리얼")

user_input = st.chat_input("User prompt")

if user_input is not None:
    # 대화 내역 저장
    st.session_state["messages"].append({"role": "user", "content": user_input})

    # 프롬프트 생성
    prompt_template = ChatPromptTemplate.from_template("{message}")
    prompt = prompt_template.format(message=user_input)

    # LLM 모델 호출
    model = ChatOpenAI(model_name="gpt-4o-mini")
    response = model.invoke(prompt)

    # 응답 저장
    st.session_state["messages"].append({"role": "ai", "content": response.content})

# 대화내역 출력
for message_dict in st.session_state["messages"]:
    with st.chat_message(message_dict['role']):
        st.write(message_dict["content"])

# streamlit run streamlit/02_streamlit_chat_exam.py