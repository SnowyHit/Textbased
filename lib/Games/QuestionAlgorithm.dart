import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///C:/D/Flutter_projects/textbased/lib/Games/Clicker.dart';
import 'file:///C:/D/Flutter_projects/textbased/lib/Games/snake.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key key}) : super(key: key) ;
  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int _counter = 1 ;
  int point = 0 ;
  bool isLoaded = false ;
  Tree qTree = new Tree();
  bool isclicker = false ;
  bool issnake = false ;
  @override
  void initState() {
    _loadCounter();
    super.initState();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = true;
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
      point = (prefs.getInt('point') ?? 0);
      isclicker = (prefs.getBool('clickerflag') ?? false);
      issnake = (prefs.getBool('snakeflag') ?? false);
    });
  }


  _incrementCounter(int x , int y) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = x;
      point = y;
      prefs.setInt('counter', _counter);
      prefs.setInt('point', point);
    });
  }


  @override
  Widget build(BuildContext context) {
    if ((_counter == 4 || _counter == 5 || _counter == 7) && !isclicker) {
      return !isLoaded ? Container() : ClickerSection();
    }
    else if((_counter == 14 || _counter == 15 || _counter == 16|| _counter == 17) && !issnake) {
      return !isLoaded ? Container() : snake();
    }
    else {
      return !isLoaded ? Container() : Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
                padding: EdgeInsets.all(20),
                color: Colors.black12,
                child: Text(
                  "${qTree.Nodes[_counter].value.line}",
                  textAlign: TextAlign.center,
                )
            ),
            Container(
              child: Column(
                children: qTree.Nodes[_counter].value.answers
                    .asMap()
                    .entries
                    .map<Widget>((answer) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: (() {}),
                        onLongPress: () {
                          setState(() {
                            if (qTree.Nodes[_counter].haschildren) {
                              point = point;
                              _incrementCounter(qTree.Nodes[_counter].children[answer.key].index, point);
                              print(_counter);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "${answer.value}",
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      );
    }
  }
}



class Tree{
  List<Question> Questions = [
    Question(" 0 Ormanın biraz içinde başıboş bırakılmış , karanlık bir kütüphanede yalnız başına oturuyorsun , önündeki kitabın sayfalarını geçerken çıkan ses kulaklarına doluyor. Yorgunluktan gözlerin kapanmak üzere ' biraz daha araştırma yaparsam iyi olabilir. Aynı şekilde , biraz uyusam ve yarın devam etsemde iyi olabilir' diye düşünüyorsun. ", [" Araştırmaya devam et" , " Evine git ve uyu"], [0 , 0] ),
    Question(" 1 Yorgun gözlerle göz gezdirdiğin kitapta yaşamla ölüm arasındaki çizgiden ve ruhlardan bahsediyor aynı konudan bahseden yüzlerce kitaptan sonra ilgini çeken bir konu gözüne çarptı , Ölüm meleği olarak resmedilen bir geyik.Mavi parlamaları olan ulu bir geyik resmedilmiş ve bunu haftalardır yaptığın araştırmada ilk defa görüyorsunBunun verdiği anlık heyecanla kitabın sayfalarını hızla çeviriyor , ve zamanın nasıl geçtiğini anlayamıyorsun.Kitapta eski bir efsaneden , hayvanların üstün güçlere sahip olduğu bir dünyadan bahsediliyor. Ancak enerjin oldukça düşüyor.Bu hikaye ilgini çektiği için devam etmek istiyorsun . Kütüphane sabahları burda çalışan tarafından düzenleniyor .eğer eve gidersen sabah bu kitabı bulamayabilirsin diye düşünüyorsun bir an. Ancak bu uykunun verdiği paranoyamı yoksa mantıklı bir düşüncemi emin olamıyorsun.Uzun süredir uyuyamadın. Kütüphane başı boş bırakılmış biryer sadece günde bir kez ona bakan birigeliyor ve hiçbir güvenlik önlemi yok." , [" Kitabı al ve eve git. " , " Kitabı bildiğin biryere bırak ve eve git " , " Araştırmaya devam et"] , [0 , 0 , 1 ] ) ,
    Question(" 2 Yorgun gözlerle karanlık ormanın içinden yavaş yavaş yürüyorsun , bunu daha önce defalarca yaptın ancak her seferinde karanlığın getirdiği hafif gerginlikile yüzleşiyorsun. Kendine 'burda sadece ufak hayvanlar olur' diye tekrara ederek rahatlıyorsun.Bu tanrı'nın unuttuğu yerde kütüphanenin ne işi var diyorsun . Ölüm ve yaşamın mitolojisihakkındaki araştırman için her kütüphanenin önemi var biliyorsun , ama konsept olarak en uygun kütüphane bu oldu diye düşünüyorsun.Aklından bunlar geçerken evine vardın , anahtarını yavaşça taktıktan sonra eski püskü kapıyı gıcırdatmamak için yavaşça açıyorsun.Onu uyandırmak istemiyorsun. Artık uykuya olan özlemin iyice arttı ver yatağına kavuştuğunda derin bir iç çekip uykuya dalıyorsun.Bu araştırman elbet bir gün onu kurtarmana yardım edecek. ", ["..." ], [0] ),
    Question(" 3 İlgini çeken birşeyin verdiği heyecan senin enerjin oluyor ve devam ediyorsun.Kitapta bahsedilen olay , yüzyıllar önce yaşadığın yerde geçmiş efsanevi bir olayEskiden büyük hayvanların büyü gücüyle hükmettiği bir dünyada yaşayan normalinsanların hikayesini anlatıyor. Buradan bazı olaylar sonucunda kurtulduklarını söylüyorlar ancakkitapta bu hikayeyi ancak bu kadar anlatmış olduklarını görüyorsun.Bu kitapta bahsedilen asıl kısım buolayların hepsinde ortak görülen geyik ve insanların savaşlarda bunu gördükleri. Geyiğin onlarınruhlarına rehberlik etmek için parladığını , ruhların son anlarının sessiz ve huzurlu olması için duyma duyusunu yok ettiğinden ,bazı geyiklerin buna benzer özelliklerde olduğundan ve bu 'ölüm tanrısı' nın yeryüzündeki yansıması olduğundan bahsediyor.Bu geyiklerin hiçbir okçu tarafından vurulamayacağını ve vurulduğunda ona zarar verenlere geçen bir lanetten bahsediliyor. Kitabın sayfalarını çevirirkensayfaların ağırlaşmaya başladığını hissediyorsun. Herşey onun için diyorsun kendi kendine. Onu kurtarmanın bir yolunu bulabilirim . . .Ve kitaba kafanı gömerek vücudunun uzun saatlerdir aradığı uykuya dalıyorsun. ", ["..." ], [0] ),
    Question(" 4 Burnuna bir yanık kokusu geliyor. Koku seni hızlıca uyandırıyor. Masanın üstünde dün okuduğun kitabın alev almış olduğunu görüyorsun. ", [" Kitabı söndürmeye çalış" ," Kütüphaneden kaç !" ], [0, 0 ] ),
    Question(" 5 Burnuna bir yanık kokusu geliyor. Koku seni hızlıca uyandırıyor. Etrafına bakıyorsun ancak dumanı göremiyorsun", [" Acilen onun odasına koş" , " Yanık kokusunu kontrol et" ], [0, 0 ] ),
    Question(" 6 Yorgun gözlerle karanlık ormanın içinden yavaş yavaş yürüyorsun , bunudaha önce defalarca yaptın ancak her seferinde karanlığın getirdiği hafif gerginlikile yüzleşiyorsun. Kendine 'burda sadece ufak hayvanlar olur' diye tekrara ederek rahatlıyorsun.Bu tanrı'nın unuttuğu yerde kütüphanenin ne işi var diyorsun . Ölüm ve yaşamın mitolojisihakkındaki araştırman için her kütüphanenin önemi var biliyorsun , ama konsept olarak en uygun kütüphane bu oldu diye düşünüyorsun.Aklından bunlar geçerken evine vardın , anahtarını yavaşça taktıktan sonra eski püskü kapıyı gıcırdatmamak için yavaşça açıyorsun.Onu uyandırmak istemiyorsun. Artık uykuya olan özlemin iyice arttı ver yatağına kavuştuğunda derin bir iç çekip uykuya dalıyorsun.Bu araştırman elbet bir gün onu kurtarmana yardım edecek. ", ["..." ], [0] ),
    Question(" 7 Dinlenmiş bir vücut ile güneşli bir sabaha uyandın. ", ["..." ], [0] ),
    Question(" 8 Kitaptaki ateş etrafa sıçramasın diye aniden yere düşürdün ve etrafında yanabilecek şeyleri hızlıca sağa sola ittirdin.Ateş çok büyümedi kitap ise taşın üstünde yanıyor. Yakında su yok . Tek su senin yanında getirdiğin matara idionu da gece bitirdin. Kitabı söndürmek için çabaladın , üstüne üstündeki ceketi örttün , ancak ateş söndüğünde kitap okunamaz halde kaldı.Yenilmiş bir şekilde evine dönüyorsun , yarım yamalak bir uyku ile .. ", ["..." ], [0] ),
    Question(" 9 Kütüphaneden hızlıca çıkıyorsun , sabah güneşi yeni çıkmış , buraya bakan adamın yakında geleceğini düşünüyorsun. Kütüphaneyle birlikte ormanda yanabilir , buranın ve ormanın yanmasının sebebinin sen olduğunu düşünürlerse durum kötü olabilir. Biraz nefes alınca sadece kitabın yandığını gördüğünü hatırladın. ", ["İçeri gir ve durumu kontrol et" , "Kaçarak evine dön ve hiçbirşeyden haberin yokmuş gibi davran , kütüphanenin yanmasına izin ver." ], [0 , 0] ),
    Question(" 10 Evin mutfağında yemek yapılıyordu. Yemeği yapan kişi o , yani Aeri'ydı. 15 yaşındaki sıska erkek çocuk , senin yanında yaklaşık birkaç aydır kalıyordu. Sağ kolundaki belirgin yara , doğaüstü birşey gibi gözüküyordu. Kolunu bir yılan gibi kaplamış siyah-mavi bir kemer gibi. O gece yine bir kütüphane sabahlamasının ardınan Aeri ile karşılaşmıştın. Onu kardeşiyle yaşadığı evine götürdükten sonra kolundaki yarayı araştırmak için bu yola çıktın. Bu yaranın sebebinin 'Ölüm meleği' Denilen canavar olduğunu düşünüyorsun. Kemer yavaşça çocuğun kolundan yükseliyor ve bunu nasıl çözebileceğine yada tam olarak nasıl birşey olduğuna dair her bilgiyi arıyorsun. Çocuk sakarca kahvaltıyı hazırlıyordu.Ekmeği yaktığını farkedince aniden ocaktan aldı , sana doğru bakıp ' Günaydın' dedi neşeli bir ses tonu ile. Sende ona kibarca karşılık verdin ve birkaç dakika sonra hazır olan kahvaltı masasına oturdunuz.", ["..." ], [0 , 0] ),
    Question(" 11 Evin mutfağında yemek yapılıyordu. Yemeği yapan kişi o , yani Aeri'ydı. 15 yaşındaki sıska erkek çocuk , senin yanında yaklaşık birkaç aydır kalıyordu. Sağ kolundaki belirgin yara , doğaüstü birşey gibi gözüküyordu. Kolunu bir yılan gibi kaplamış siyah-mavi bir kemer gibi. O gece yine bir kütüphane sabahlamasının ardınan Aeri ile karşılaşmıştın. Onu kardeşiyle yaşadığı evine götürdükten sonra kolundaki yarayı araştırmak için bu yola çıktın. Bu yaranın sebebinin 'Ölüm meleği' Denilen canavar olduğunu düşünüyorsun. Kemer yavaşça çocuğun kolundan yükseliyor ve bunu nasıl çözebileceğine yada tam olarak nasıl birşey olduğuna dair her bilgiyi arıyorsun. Çocuk sakarca kahvaltıyı hazırlıyordu.Ekmeği yaktığını farkedince aniden ocaktan aldı , sana doğru bakıp ' Günaydın' dedi neşeli bir ses tonu ile. Sende ona kibarca karşılık verdin ve birkaç dakika sonra hazır olan kahvaltı masasına oturdunuz.", ["..." ], [0 , 0] ),
    Question(" 12 Evin mutfağında yemek yapılıyordu. Yemeği yapan kişi o , yani Aeri'ydı. 15 yaşındaki sıska erkek çocuk , senin yanında yaklaşık birkaç aydır kalıyordu. Sağ kolundaki belirgin yara , doğaüstü birşey gibi gözüküyordu. Kolunu bir yılan gibi kaplamış siyah-mavi bir kemer gibi. O gece yine bir kütüphane sabahlamasının ardınan Aeri ile karşılaşmıştın. Onu kardeşiyle yaşadığı evine götürdükten sonra kolundaki yarayı araştırmak için bu yola çıktın. Bu yaranın sebebinin 'Ölüm meleği' Denilen canavar olduğunu düşünüyorsun. Kemer yavaşça çocuğun kolundan yükseliyor ve bunu nasıl çözebileceğine yada tam olarak nasıl birşey olduğuna dair her bilgiyi arıyorsun. Çocuk sakarca kahvaltıyı hazırlıyordu.Ekmeği yaktığını farkedince aniden ocaktan aldı , sana doğru bakıp ' Günaydın' dedi neşeli bir ses tonu ile. Sende ona kibarca karşılık verdin ve birkaç dakika sonra hazır olan kahvaltı masasına oturdunuz.", ["..." ], [0 , 0] ),
    Question(" 13 Evin mutfağında yemek yapılıyordu. Yemeği yapan kişi o , yani Aeri'ydı. 15 yaşındaki sıska erkek çocuk , senin yanında yaklaşık birkaç aydır kalıyordu. Sağ kolundaki belirgin yara , doğaüstü birşey gibi gözüküyordu. Kolunu bir yılan gibi kaplamış siyah-mavi bir kemer gibi. O gece yine bir kütüphane sabahlamasının ardınan Aeri ile karşılaşmıştın. Onu kardeşiyle yaşadığı evine götürdükten sonra kolundaki yarayı araştırmak için bu yola çıktın. Bu yaranın sebebinin 'Ölüm meleği' Denilen canavar olduğunu düşünüyorsun. Kemer yavaşça çocuğun kolundan yükseliyor ve bunu nasıl çözebileceğine yada tam olarak nasıl birşey olduğuna dair her bilgiyi arıyorsun. Çocuk sakarca kahvaltıyı hazırlıyordu.Ekmeği yaktığını farkedince aniden ocaktan aldı , sana doğru bakıp ' Günaydın' dedi neşeli bir ses tonu ile. Sende ona kibarca karşılık verdin ve birkaç dakika sonra hazır olan kahvaltı masasına oturdunuz.", ["..." ], [0 , 0] ),
    Question(" 14 Kahvaltının ardından kapı çaldı . Kapıyı açtığında karşında iri yarı bi adam gördün . 'Buraya yakın bir kütüphanede ilginç bir kitap vardı , ancak onu bulamıyorum acaba onu sizmi aldınız ?' Soruyu duyduğunda gerildin , ancak adama belli etmediğinden eminsin. Adamda sinirli gözükmüyor. Gayet normal bir soru gibi sordu. ", ["1. Sona ulaştın" ], [0] ),
    Question(" 15 Kahvaltının ardından kapı çaldı . Kapıyı açtığında karşında iri yarı bi adam gördün . 'Buraya yakın bir kütüphanede ilginç bir kitap vardı , ancak onu bulamıyorum ve kütüphanede yanık izleri var ,  ne olduğunu biliyormusunuz ?' dedi adam sakince", ["2. Sona ulaştın" ], [0] ),
    Question(" 16 Kahvaltının ardından kapı çaldı . Kapıyı açtığında karşında iri yarı bi adam gördün . 'Buraya yakın bir kütüphanede yangın çıkmış , içinde çok ilgimi çeken bir kitap vardı acaba bunun hakkında bilgi sahibi olabilirmisiniz ?' dedi adam sakince", ["3. sona ulaştın" ], [0] ),
    Question(" 17 Kahvaltının ardınan iyi başlamış bir gün diye düşünüp , Heyecan ile kütüphaneye doğru gidiyorsun.", ["4. sona ulaştın" ], [0] ),

  ];

  List<Node> Nodes= [] ;

   Tree(){
     int x = 0 ;
     for (var Q in Questions)
     {
       Nodes.add(Node(Q , x));
       x = x+1 ;
     }
     Nodes[0].Addchild([Nodes[1] , Nodes[2]]) ;
     Nodes[1].Addchild([Nodes[6] , Nodes[2] , Nodes[3]]) ;
     Nodes[2].Addchild([Nodes[7]]) ;
     Nodes[3].Addchild([Nodes[4]]) ;
     Nodes[4].Addchild([Nodes[8], Nodes[9]] ) ;
     Nodes[5].Addchild([Nodes[10]]) ;
     Nodes[6].Addchild([Nodes[5]]) ;
     Nodes[7].Addchild([Nodes[13]]) ;
     Nodes[8].Addchild([Nodes[11]]) ;
     Nodes[9].Addchild([Nodes[8] , Nodes[12]]) ;
     Nodes[10].Addchild([Nodes[14]]) ;
     Nodes[11].Addchild([Nodes[15]]) ;
     Nodes[12].Addchild([Nodes[16]]) ;
     Nodes[13].Addchild([Nodes[17]]) ;
     Nodes[14].Addchild([Nodes[14]]) ;
     Nodes[15].Addchild([Nodes[15]]) ;
     Nodes[16].Addchild([Nodes[16]]) ;
     Nodes[17].Addchild([Nodes[17]]) ;
   }


}

class Question {
  String line ;
  List<String> answers ;
  List<int> points ;
  Question(String line , List<String> answers , List<int> points )
  {
    this.line = line ;
    this.answers = answers ;
    this.points = points ;
  }

}

class Node<Question> {
  int index ;
  Question value;
  bool haschildren ;
  List<Node<Question>> children;
  Node(Question value , int index)
  {
    this.index = index ;
    this.value = value ;
    this.children = children ;

  }

  void Addchild(List<Node<Question>> children){
      this.children = children ;
      haschildren = true ;
  }
}