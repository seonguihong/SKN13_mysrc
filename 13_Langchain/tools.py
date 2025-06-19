# tavily_search를 이용해서 web검색을 처리하는 툴
from typing import Literal # 넣을 수 있는 값이 정해진 경우.
# type|None -> optional
from langchain_tavily import TavilySearch
from langchain_core.tools import tool
from langchain_community.document_loaders import WikipediaLoader
from langchain_core.runnables import chain
from pydantic import BaseModel, Field

# @tool
@tool(name_or_callable="Search_Web", description="데이터베이스에 존재하지 않는 정보나, 최신정보를 찾기 위해서 인터넷 검색을 하는 Tool입니다.",
      # args_schema = 설정한 pydantic스키마
      )
def search_web(query:str, max_results:int=3, time_range:Literal["day", "week", "month", "year"]|None=None) -> dict:
    """
    데이터베이스에 존재하지 않는 정보나, 최신정보를 찾기 위해서 인터넷 검색을 하는 Tool입니다.
    """

    #######################################################################
    # tavily_search 이외의 검색 툴들을 이용해서 다양한 검색 결과들을 취합
    #######################################################################
    

    tavily_search = TavilySearch(max_results=max_results, time_range=time_range)
    search_result = tavily_search.invoke(query)["results"] # {..., "results":list[dict. dict, ...]}
    if search_result: # 검색결과가 존재.
        return {"result" : search_result}
    else: # 검색결과가 존재하지 않음.
        return {"results" : "검색결과가 없습니다."}
    
@chain
def wikipedia_search(input_dict:dict)->dict:
    """사용자 query에 대한 정보를 wikipedia에서 k개의 문서를 검색하는 Runnable"""

    query = input_dict['query'] # 검색어
    max_results = input_dict.get("max_result", default=2) # 조회문서 최대 개수. / default : 2

    wiki_loader = WikipediaLoader(query=query, load_max_docs=max_results, lang="ko")
    search_result = wiki_loader.load()
    if search_result:
        result_list = []
        for doc in search_result:
            result_list.append({"content":doc.page_content,"url":doc.metadata['source'],"title":doc.metadata["title"]})
            return {"result": result_list}
        else:
            return {"result":"검색결과가 없습니다."}
        
class SearchWikiArgsSchema(BaseModel):
    query : str = Field(... , description="위키백과사전에서 검색할 키워드, 검색어")
    max_results: int = Field(default=2, description="검색할 문서의 개수")

# Runnable을 tool로 생성 - Runnable.as_tool(툴 정보)
search_wiki = wikipedia_search.as_tool(
    name="search_wikipedia", # 툴 이름
    description=("위키백과사전에서 정보를 검색할 떄 사용하는 tool."
                 "사용자의 질문과 관련된 위키백과사전의 문서를 지정한 개수만큼 검색해서 반환합니다." \
                 "일반적인 지식이나 배경 정보가 필요한 경우 유용하게 사용할 수 있는 tool입니다."
                  ), # 툴 설명
    args_schema= SearchWikiArgsSchema # 파라미터(parameters)에 대한 설계 -> pydantic으로 모델 정의
)
