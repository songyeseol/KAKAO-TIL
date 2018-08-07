### 입력 함수 

x = scan() # 숫자 데이터 

y = scan(what="") # 문자 데이터 

z = scan(n=1) # 입력받을 데이터 개수 지정 

f1 = scan("input.txt") # 파일로부터 데이터 숫자 읽기 

f2 = scan("input.txt", what="") # 파일로부터 데이터 문자 읽기

### 출력 함수 

# print() : 화면에 데이터 출력 / 다음 줄로 자동으로 넘어감 / 괄호 생략 가능 

print("hello world")

("hello world") 

print("hello world",x) # 이거는 에러 

# cat() : 데이터를 연결하여 화면에 출력 / 데이터 출력 후에도 다음 줄로 넘어가지 않음 / 넘기고 싶다면 "\n"을 함께 써야함 

cat("hello world")

cat("hello world\n hi")

cat("hello world",x) # 요거는 출력
