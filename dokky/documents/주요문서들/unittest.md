## 테스트 코드 작성 설계가 필요한 이유

 	- 무작정 뛰어들어 스타트하기보다 방향부터 제대로 잡고 가야 효율성을 살릴 수 있다.
 	- 즉 코딩하고, 또 다시 고치기 위한 작업을 최소화하기 위해 처음에 방향성을 잘 잡아보자

### 1) 테스트 구조 방향성- AAA테스트 일관성 유지(모든 테스트 코드를 AAA로 잘 조직하고 구조화 해보자)

 	- Arrange(준비) : 테스트 에서는 어떤 것을 하기 위해서는 먼저 테스트 상태를 설정하는 준비 단계의 일들을 해야함
 	테스트 코드를 실행하기 전에 시스템이 적절한 상태에 있는지 확인, 객체들을 생성하거나 , 다른 api를 호출하는것등

 	- Act(실행) : 테스트를 준비한 후에는, 검증하려는 코드인 메서드를 실행, 보통은 단일 메서드를 호출

 	- Assert(단언) : 마지막으로 기대하는 결과를 단언
 	실행하는 코드가 기대한 대로 동작하는지 확인, 실행한 코드의 반환값 혹은 그외 필요한 객체들의 새로운 상태를 검사
 	단언은 어떤 조건이 참인지 검증하는 방법, 참이 아니면 테스트는 실패

 	- 일반적인 단언과 hamcrest 단언을 적절히 잘 써보자
 	- assertThat() 정적 메서드는 명확한 값을 비교한다. 실패할 경우에 오류 메시지에서 더많은 정보를 알 수 있음
 	- 스택 트레이스에서 더욱 자세한 정보를 얻을수있다.
 	- 매처를 몇개만 사용해도 되지만, 더 많은 햄크레스트 매처를 도입할수록 테스트 코드의 표현력이 깊어짐
	- 가독성이 좋아질 수 있음
	- 물론  hamcrest 단언의 단점은 불필요한 코드가 생겨날수 있음
 	
### 2) 좋은 테스트의 first속성

fast(빠른)
	
 	유닛 테스트는 빨리 돌아야 한다.
 	느리면 자주 돌릴 엄두를 못 낸다.
 	자주 못돌리면 초반에 문제를 찾아내 고치지 못한다.
 	결국 코드 품질이 망가지기 시작한다.
 	느린것에 의존하는 코드를 최소화하는것이 좋은 설계

Isolated(고립된),Independent(독립적인)
	
 	- 각각의 테스트는 독립적이어야함 	
 	- 다른 테스트에 종속적,상호의존적인 테스트는 절대로 작성하지 않는다.
	- 각 테스트는 직접적 혹은 간접적으로 서로 의존하면 안 된다.
 	- 어떤 테스트 코드가 다른 테스트에 영향을 주는것을 최소화 static 필드를 피해야한다. 
	- 한 테스트가 다음 테스트가 실행될 환경을 준비해서는 안 된다. 
	- 각 테스트는 독립적으로 그리고 어떤 순서로 실행해도 괜찮아야 한다.
	- 즉 테스트 코드는 어떤 순서나 시간에 관계없이 실행할 수 있어야함
	- 테스트가 서로에게 의존하면 문제가 발생할 소지가 늘어난다
	    하나가 실패할 때 나머지도 잇달아 실패하므로 원인을 진단하기 어려워지며 후반 테스트가 찾아내야 할 결함이 숨겨진다.
	- 즉 여러 테스트가 생성된 데이터를 재사용하는 방식으로 테스트 순서를 조작하여 전체 테스트의 실행 속도를 높이려고 
	    할수도 있지만 이렇게 하면 의존성의 악순환만 동시에 발생, 
	    일이 잘못되면 테스트가 실패했을때 앞선 이벤트에서 무엇이 원인인지 알아내르라 더 긴시간 소모
 	- 각 테스트가 작은양의 동작에만 집중하면 테스트 코드를 집중적이고 독립적으로 유지하기 쉬워짐
 	- 모든 테스트를 독립적으로 만들기 위해 테스트마다 새로운 인스턴스를 생성
 	- 그렇지 않고 동일한 인스턴스에서 실행된다면 공유된 객체의 상태를 정리하는것도 걱정해야하기 때문
  	- 하나의 테스트 메소드에 여러가지 기능을 집중하게되면
 	    공통초기화의 부담을 줄일수는 있지만 테스트고립의 중요한 이점을 잃게됨, 테스트 이름 또한 의미를 잃게됨
 	- 좀더 작은 여러 테스트 메소드로 분리하여 고립시키면 단언이 실패했을때 실패한 테스트 이름이 표시되기 때문에 어느 동작에서
 	    문제가 있는 빠르게 파악가능
 	- 고립시키면 각 테스트 이름에 더 많은 의미,구체적으로 부여할 수 있음
 	- 실패한 테스트를 해독하는데 필요한 시간을 줄일수 있음
 	- 현재 실패한 테스트에 대해 다른 테스트의 영향을 제거가능

Repeatable(반복가능한)

 	- 테스트는 어떤 환경에서도 실행할 때마다 같은 결과를 만들어야 한다.(예를 들어 시간변화에 독립성 유지 )
 	- 직접 통제할수 없는 외부 환경에 있는 항목들과 격리시켜야 한다(네트워크가 연결되지 않은 환경 에서도 실행할 수 있어야 한다?
 	꼭 메모리 내에서만 실행되는 테스트여야 한다는 법칙은 없다 데이터베이스, 네트워크 엑세스, 파일 시스템 등을 사용하여도 단위테스트의 레벨일 수는 있다?
 	)
		
Self-validating(스스로 검증 가능한)
 	
 	- 테스트는 스스로 결과물이 옳은지 그른지 판단할 수 있어야 한다. 
 	- 특정 상태를 수동으로 미리 만들어야 동작하는 테스트 등은 작성하지 않는다.
 	- 테스트 결과를 수동으로 검증하는 것은 시간 소모적인 절차이고 리스크가 늘어난다.
 	- 멍해지기 쉽고 코드가 출력해 내는 거대한 로그를 보다가 중요한 신호를 놓칠수도 있다
	- 단위 테스트는 시간을 소모하기보다는 절약한다
 	- 테스트는 기대하는 것이 무엇인지 단언하지 않으면 테스트가 아니다. 
 	- 테스트는 bool 값으로 결과를 내야 한다. 성공 아니면 실패다. 
 	- 통과 여부를 알리고 로그 파일을 읽게 만들어서는 안 된다. 
 	- 테스트가 스스로 성공과 실패를 가늠하지 않는다면 판단은 주관적이 되며 지루한 수작업 평가가 필요하게 된다.
 	 
 	- 자동화 테스트에 필요한 설정단계 자동화
	- 테스트를 언제 어떻게 실행할지도 자동화
 	- 이클립스의 infinitest같은 도구 > 시스템이 변경되면 infinitest는 이들을 식별하고
 	- 백드라운드로 잠재적으로 영향을 받는 테스트들을 실행
 	- 좀더 큰 규모에서는 젠킨스 같은 지속적 통합 ci 도구를 사용
 	- ci도구가 소스 저장소를 관찰하여 변화를 감지하면 빌드와 테스트 절차를 시작
 	- 코드를 소스 저장소에 통합할때마다 빌드가 자동으로 수행되고 모든 테스트를 실행

Timely 적시의

 	- 테스트는 적시에 작성해야 한다.
 	- 단위 테스트는 테스트하려는 실제 코드를 구현하기 직전에 구현한다.
 	- 실제 코드를 구현한 다음에 테스트 코드를 만들면 실제 코드가 테스트하기 어렵다는 사실을 발견할지도 모른다.
 	- 어떤 실제 코드는 테스트하기 너무 어렵다고 판명날지 모른다.
 	- 테스트가 불가능하도록 실제 코드를 설계할지도 모른다.

 	- 적절한 순가에 단위 테스트에 집중하는것이 낫다
 	- 적시에 단위 테스트를 작성하는 습관
 	- 옛날 코드에 대한 테스트는 시간 낭비가 될수 있다
 	- 코드에 큰 결함이 없고 당장 변경할 예정이 없다면 시간낭비가 될수있다
 	- 좀 더 변화가많고 말썽이 많을것 같은 부분에 투자
 
### 3) 어노테이션 활용(중복 로직 제거)
	
 	- 애노테이션을 활용하여 공통 로직 초기화 및 정리 코드를 설정하는 방법
	
 	- @Before으로 표시된 메서드를 먼저 실행
  	  (공통적인 초기화 코드)예시 객체의 초기화  > 가독성 향상, 효율을 높임

 	- @Before메소드도 여러개 만들어 테스트 실행전에 여러개 동작하게끔
 	- 하나의 메서드에 결합하기보다 여러개로 분할을 하자 그게 좋다
 	- 문제는 이 Before메소드도 실행순서는 보장하지 않는다. 순서가 필요할땐 결합을 해야함

 	- @After메서드는 클래스에 있는 각 테스트를 동작후 실행
 	- 테스트가 실패하더라도 실행됨(예를들어 열려있는 데이터베이스 연결을 종료)

 	- @BeforeClass-이것은 클래스에 있는 어떤 테스트들을  실행하기 전에 딱 한번만 실행

 	- @AfterClass-실행후 딱 한번 실행

 	- @Ignore("주석 대신 넣기")-테스트를 무시
 	   주석처리하지말고 이렇게 애노테이션을 달아 무시하자
 	   그래야 나중에 다시보게되지 주석처리하면 보지않음	
 	
### 4) 기타 테스트의 방향성
 	
 	- 이미 테스트 하기 쉽게 만들어져 있는 코드로 시작하자 > 순수 메서드로 만들어져 있거나 ,외부의존성이 없는것,인풋과 아웃풋이 명확한것, 단순한 기능
 	메서드를 정해서 제대로된 인풋을 넣고 아웃풋이 나오는지 확인하는 테스트를 만들어볼것
 	- 테스트 하기 어렵게 만들어져 있는 코드에서 테스트 하기 쉬운 것만 분리하자
 	- 이때 선택의 기준은 중요도가 높은 비즈니스 로직이 포함된 부분, 버그가 발견된 부분, 결합이 낮고 논리는 복잡한 부분
 	외부의존도가 낮거나 없고 비즈니스 로직은 복잡한부분
 	
 	- 코드 결함을 찾는 것도 중요하지만 테스트는 결국 더 좋은 소프트웨어와 코드 품질을 갖도록 도와주어야 한다.
 	- 유지하기 힘들고 별로 가치 없는 테스트 코드가 아닌 올바른 방법으로 가치 있는 단위 테스트를 만들수 있도록
 	- 테스트를 더 단순하게 작성할 수 있도록 테스트 코드를 정기적으로 정리 필요  	
 	- 작은 양의 코드로 테스트를 만들기
 	- 테스트를 코드 자체만으로 이해할 수 있게 작성하기  or 테스트 이름을 변경
	- 단위 테스트는 구현한 클래스에 대해 지속적이고 믿을 수 있는 문서 역할을 해야한다.
	- 테스트 코드를 다른 사람에게도 의미 있게 만드는것
 	- 테스트를 사용하는 사람에게 어떤 정보도 주지못하는 테스트가 되어서는 안된다
 	- 다른 사람이 테스트가 어떤 일을 하는지 파악하기 어려워 한다면 주석을 추가하는것만으로 끝내지말고 테스트 이름을 개선해야 한다. 
 	- 테스트 이름과 코드를 재작업하여 부가적으로 주석을 넣지 않고도 스토리를 알수 있도록
 	- 추가적으로 지역 변수 이름 개선하기, 의미 있는 상수 도입하기

### 5) 테스트코드를 작성해야 하는 이유
	
 	- 테스트 안해서 아낀 시간  < 테스트 안해서 나온 버그 고치는 시간
 	- 비즈니스 로직의 허점을 일찍 발견
 	- 예상한 대로, 의도한 대로 작동하는지 알고 싶기 때문
 	- 현재 동작을 더 잘 이해하고 싶기 때문
 	- 자신과 다른 사람들이 나중에 이해하도록 하고 싶기 때문
 	- 다른사람이 같은 영역의 코드를 변경할때도 테스트가 필요하기 때문
 	- 테스트 코드는 이후 다른 변경 사항으로 인해 발생 가능한 결함을 찾아내는 역할
 	- 코드를 변경하고 그것으로 변경된 사항이 기존 동작을 깨뜨리지 않았는지 확인하고 싶기 때문
 	- 문제가 있다면 즉시 중단하고 고칠수 있고, 문제의 발견이 쉽기 때문
 	- 프로덕션 시스템 배포에 대한 자신감을 높여주기 때문
 	- 불안감 없이 코드 작성을 할 수 있도록 도와주고, 결과적으로 생산성을 매우 높여 줌
	- 디버깅을 쉽게 해주고, 실패한 테스트는 고퀄리티의 버그 리포트가 될 수 있다
	- 더 깔끔하고 재사용성이 좋은 코드 작성을 가능하게 해줌
	- 테스트코드는 스펙 문서의 기능을 한다,코드의 올바른 동작에 대한 하나의 스펙문서 : 테스트코드만 보아도 이 함수가 어떻게 동작해야하는지를 알 수 있다.
	(본인이 만든 함수의 세부사항을 모두 기억하기는 어렵다.그래서 함수를 쓸려고 할때, 
	함수를 다시 찾아들어가고 구현을 이해하고, 이렇게 써야겠구나 확인을 하며 시간을 소비 하지만, 테스트 코드를 작성한다면 이 함수가 어떤 기능을 하는 함수인지 테스트 코드만 보고도 쉽게 확인할수 있다.
	 코드를 이해하는 시간이 줄어듬) 
	
### 5) 단위 테스트가 필요한 이유	
	
 	- 단위테스트는 가장 작은 단위의 테스트이다, 보통 메서드 레벨이다
 	- A라는 함수가 실행되면 B라는 결과가 나온다 정도로 테스트한다
 	- 프로그램의 각 부분을 고립 시켜서 각각의 부분이 정확하게 동작하는 확인
 	- 프로젝트에서는 여러 컴포넌트를 각각 개발하는 경우가 많다. 이때 해당 연관된 컴포넌트가 완성되지 않으면 내 코드가 정상동작하는지 알 방법이 없다
 	- 단위 테스트는 메서드 단위의 테스트로 어플리케이션이 기대한 대로 잘 동작함을 증명하고, 버그를 조기에 잡아내는 것을 기본 목적으로 한다.
 	- 단위 테스트를 사용하면 연관 컴포넌트가 개발되지 않더라도 개발이 마무리 됬다고 증명할 수 있다. 
 	- 가짜 객체(Mock Object)를 이용하여 API문서에 맞게 기대값을 설정하여 테스트한다면 외부 컴포넌트가 완성되지 않았더라도 본인의 컴포넌트만을 이용하여 검증할 수 있다
	- 유닛 테스트를 믿고 개발자는 리팩토링(Refactoring, 기능은 동일하게 유지하면서 프로그램의 구조를 변경하는 작업)을 할 수 있음, 이를 회귀 테스트(Regressing Testing)이라고 함
 	    어떻게 고치더라도 문제점을 쉽게 파악 할 수 있게 되므로, 프로그래머들은 의욕적으로 코드를 변경하게 됨

### 6) 테스트 종류
 	
![image](https://user-images.githubusercontent.com/35983608/81816631-952a4680-9566-11ea-8b27-f65a7eb07186.png)
 	
 	- 단위 테스트(Unit test) :
 		(논리 단위 테스트 : 한 메서드에 집중한 테스트로 가짜 객체(Mock Object)나 stub을 이용해 테스트 메서드의 경계를 제어할 수 있다.)
 		(통합 단위 테스트 : 실제 운영 환경(혹은 그 일부)에서 컴포넌트 간 연동에 치중한 테스트, 예를 들어 데이터베이스를 사용하는 코드라면 데이터베이스를 효과적으로 호출하는가를 테스트)
 	- 통합 테스트(Integration test) : 단위테스트 이후, 각 모듈들의 상호 작용이 제대로 이루어지는지 검증하는 테스트 활동,
 								    단위 테스트가 끝난 모듈을 통합하는 과정에서 발생할 수 있는 오류를 찾는 테스트
								    여러 작업 단위가 연계된 워크플로우를 테스트 하기 위한 수단(객체 간, 서비스 간, 시스템 간)
 								    변경할 수 없는 부분(외부 라이브러리 등)까지 묶어서 같이 테스트 할 떄 사용
 								    
 	- 기능 테스트 : 공개된 API의 가장 바깥쪽에 해당하는 코드 검사( Controller 호출, Security, http )
 	- 부하 테스트 : 주어진 단위 시간 동안 어플리케이션이 얼마나 많은 요청을 처리할 수 있는지 검사
 	- 승인,인수 테스트(Acceptance test) : 고객 또는 대리인이 정의되어진 모든 목적에 부합되는지 확인해보고자 하는 검사

### 7) 고민사항

 	- 단위 테스트 개념은 도대체 어느정도로 작게 유지해야할것인가?
 	    이에 대해 아직 감이 없다..테스트를 얼마나 작게 할것인가?
 	    테스트 코드는 하나의 단일 행동을 테스트하는 코드여야 한다.
 	    테스트 코드를 다시 구현해가면서 감을 잡아야 할것 같다

 	- 내가 하고 싶은건 통합테스트인것인가?아니면 단위테스트인것인가?
 	    단위테스트가 테스트하는 범위가 굉장히 좁다면 나는 통합테스트를 하고싶었던것인가?
 	    통합테스트에 대한 조사가 필요하다 .
 	    
 	- 그래서 정확히 무엇을 목표로 테스트를 하는것인가
 	   단위 테스트의 최종 목표(어떤 특정한 요구사항에 대한 테스트)
 	   
### 8) 느낀점
	
 	- 생각했던것보다도 훨씬..테스트가 만만치 않다..어려운 일이다..꾸준히 쭉 계속해서 알아가고 쌓아가야할 것 같다.
 	- 내 프로젝트에 자신감이 없는 이유 : 검증되지 않았다. 내 프로젝트를 내가 제대로 이해 못하는 부분들이 있다. 제대로 된 코드라고 확신할 수 가 없다.
  	테스트 코드 작성들을 통해 불안감을 없애고 자신감을 찾아야한다.
 	- 항상 개발자는 변화해야한다. 그 방향성은 자동화,효율성(비용 관점),안정성,성능향상등이지 않을까
 	- 테스트 또한 자동화,효율성,안정성등을 위한것이라 생각이 든다

### 9) TDD VS Test Last

![image](https://user-images.githubusercontent.com/35983608/81820239-4f23b180-956b-11ea-93d9-ccae3d1b4d3b.png)

현재 나의 프로젝트 방향성 : Test Last 방식으로 선택 but 새로운 요구사항은 TDD로

### 10) 참고자료
책 : 자바와 JUnit을 활용한 실용주의 단위 테스트
https://sabarada.tistory.com/68
https://www.youtube.com/watch?v=1bTIMHsUeIk&t=218s
https://www.slideshare.net/OKJSP/okkycon-120498066

### 11) 테스트 구조화 조직

- 메서드를 테스트 하는 것이 아니라 동작을 테스트 하여 테스트 코드의 유지 보수성읖 높이는 방법

 	동작 테스트 vs 메서드 테스트
 	테스트를 작성할때는 클래스 동작에 집중해야 하며 개별 메서드를 테스트 한다고 생각하면 안된다
 	단위 테스트를 작성할때는 먼저 전체적인 시각에서 시작해야 한다.
 	개별 메서드를 테스트 하는것이 아니라 클래스의 종합적인 동작을 테스트 해야 한다.
 	
테스트 주도개발
테스트를 먼저 작성하고 코드를 작성하면 이전과 다른 더 좋은결과
많은사람이 이를 가리켜 테스트 주도개발 tdd

일반적인 단위 테스트와 tdd차이점은 tdd에서는 테스트를 먼저 작성
먼저 작성하든 이후에 작성하든 first 원리를 고수하면 됨

단위테스트에서 
테스트 대상 코드는 데이터베이스를 읽는 다른 코드와 상호작용할수도있음
 	데이터 의존성을 많은 문제를 만듬
 	궁극적으로 데이터베이스에 의존해야 하는 테스트는 디비가 올바른 데이터를 
 	가지고있는지 확인해야 한다. 데이터 소스를 공유한다면 테스트를 깨뜨리는 외부 변화도
 	걱정해야 한다. 가용성 혹은 접근성 이슈로 실패할 가능성이 증가
 	좋은 단위테스트는 다른 단위 테스트에 의존하지 않는다.


### 12) Right-BICEP 무엇을 테스트 할 것인가?

Right 결과가 올바른가?

테스트 코드는 무엇보다도 기대한 결과를 산출하는지 검증할 수 있어야 한다

B 경계조건(boundary conditions)은 맞는가?

경계조건에서는 CORRECT를 기억하라

I 역 관계(inverse relationship)를 검사할 수 있는가?

C 다른 수단을 활용하여 교차 검사(cross-check)할 수 있는가?

E 오류 조건을(error conditions) 강제로 일어나게 할 수 있는가?

p 성능 조건(performance characteristics)은 기준에 부합하는가?



	
 