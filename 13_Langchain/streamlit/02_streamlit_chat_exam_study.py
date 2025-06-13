
import streamlit as st
from dotenv import load_dotenv
from langchain_openai import ChatOpenAI


# @st.cache_resource -> cache에 저장 
@st.cache_resource
def get_llm_model():
    load_dotenv()
    return ChatOpenAI(model_name="gpt-4o-mini")

# 모델이 session에 이미 존재하면 가져다 쓰고 없을 시 새로 생성하는 코드.
# if "model" not in st.session_state:
#     st.session_state["model"] = ChatOpenAI(model_name="gpt-4o-mini")
# model = st.session_state['model']

model = get_llm_model()


if "messages" not in st.session_state:
    st.session_state["messages"] = [] 

for message in st.session_state["messages"]:
    with st.chat_message(message["role"]):
        st.write(message["content"])



st.title("Chatbot + Session_state 튜토리얼")


prompt = st.chat_input("User prompt")


if prompt is not None:
    st.session_state["messages"].append({"role":"user", "content":prompt})
    with st.chat_message("user"):
        st.write(prompt)




# streamlit run streamlit/02_streamlit_chat_exam_study.py