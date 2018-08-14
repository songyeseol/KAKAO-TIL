# (1) 크기 의존적 에러 (scale dependent error)

## - RMSE (Root Mean Squared Error)

![image](https://user-images.githubusercontent.com/28600272/44090931-c366e668-a006-11e8-8da4-c3acc6da946b.png)

- 예측값과 실제값을 뺀 후 제곱시킨 값들을 더하고 n으로 나눔, 그리고 루트
- 표준편차 구하는 공식
- 단점: 예측 대상의 크기에 따라 영향받음 = 크기 의존적 에러 


# (2) 비율 에러 (percentage errors)

## - MAPE (Mean Absolute Percentage Error)

![image](https://user-images.githubusercontent.com/28600272/44091114-5d48ee70-a007-11e8-9f62-065294b41cf3.png)

- 예측값과 실제값을 뺀 후 이를 실제값으로 나눈 값을 모두 더하고 n으로 나눔, 그리고 백분율 표현
- 오차변동폭을 실제값으로 나눠보면 비율상 같은 기준으로 비교할 수 있음 
- 단점: 실제값이 1보다 작을 때 발생. MAPE가 무한대에 가까운 값을 찍을 수도 있음. 또한 실제값이 0이라면 MAPE 값 자체 계산 불가. 

# (3) 크기 조정된 에러 (scaled error) 

## - Mean Absolute Scaled Error

![image](https://user-images.githubusercontent.com/28600272/44091222-b38c4e8a-a007-11e8-9cf0-8b01caafae1b.png)

- 예측값과 실제값의 차이를 평소에 움직이는 평균 변동폭으로 나눈 값 
- MAPE가 오차를 실제값으로 나누었자면, MASE는 평소의 변동폭에 비해 얼마나 오차가 차이나는지 측정
- 변돋ㅇ성이 큰 지표와 변동성이 낮은 지표를 같이 예측할 필요가 있을 때 유용
