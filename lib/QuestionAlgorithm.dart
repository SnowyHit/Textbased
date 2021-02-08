import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textbased/Clicker.dart';

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
    if (_counter == 4) {
      return !isLoaded ? Container() : ClickerSection();
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
    Question(" Macerana Başlıyorsun. Sıkıcı bir ofis hayatında çalışan boş beleş bir insan ..", [".."], [0] ),
    Question(" ZZZZZZZt! Alarmın çalıyor. " , [" Alarmı sustur ve işe git. " , " Alarmı sustur v... "] , [0 , 0 ] ) ,
    Question(" Telefonun Çalıyor, \"İş Ali\". İçinden \"hasiktir...\" diyorsun. " , ["Aceleyle hazırlanıp işe git!  " , " Siktir et. "] , [0 , 0 ] ) ,
    Question(" Müdürün günlük fırçasını kayarken her zamanki gibi hayatın anlamını düşünüyorsun. " , [" İşe başla... "] , [0 ] ) ,
    Question(" Belin ağrıyor... Beyaz yakalı olmanın dünyadaki en iyi iş olmadığını tekrar fark ediyorsun. Neyse ki yarım saat sonra paydos ve yarın tatil diyorsun ama iş arkadaşın mesai olduğunu hatırlatıyor... " , [ "Hayatı sikim..."] , [0 ] ),
    Question(" İş çıkışı arkadaşlarını bara giderken görüyorsun. " , [" \"Bir kaç biradan bir şey olmaz.\" ", " \"Zaten yorgunum bi' de milletle mi uğraşıcam?\" "], []),
    Question(" Arkadaşlarınla bar yolunu tutuyorsun. Barını neon ışıkları gözünü alıyor \"Vlad\'ın Yeri AmBar\". Saat Kavramı senin için anlamını yitiriyor. Koluna bakıyorsun saat gece yarısını geçmiş hatta iki olmuş. " , [" Dibini görmeyen ana... ", " Laura\'yı ara ve onu çok sevdiğini, seni neden böyle terkedip gittiğini sor... çocuklarına selam söyle. :( ", " \"Siz de mi hep bu bara gelirsiniz?\" ", " \"Galiba eve gitmem gerekiyor\" "], []),
    Question(" Telefonunu arıyorsun, arıyorsun ama yok. Lan telefon zaten elindeymiş, \"Son tekilayı vurmasamıydım?\" diyorsun ama iş işten çoktan geçmiş. Telefonda Numarayı bulm... ", [" ... "], []),
    Question(" Kadın ufak bir gülücük atıyor ve birasını yudumlamaya devam ediyor. Sen de gülücükten aldığın gazla devam ediyorsun. sırtından birisi seni dürtüyor. ", [" \"Şu an işim var görmüyor musun!?\" "], []),
    Question(" Bir daha dürtüyor ve ne var diye arkanı dödüğünde bir ışık hüzmesi görüyorsun. ", [" ... "], []),
    Question(" Tuvaletin geliyor ve tuvalete gidiyorsun. Bir bar tuvaleti gece 2 de nasıl olması gerekiyorsa öyle, temiz ve mis kokulu. İşini görüp yüzünü yıkıyorsun ve kendine bir daha içmemek için tekrar söz veriyorsun. Geri döndüğünde bir şeyler eksik diyorsun. Arkadaşların yok! Puştlar seni ekmiş gibi. ", [" Aramaya çalış. ", " Siktir et. Eve git. "], []),
    Question(" İlk önce telefonuna davanıyorsun ama telefonunun şarjının bittiğini fark ediyorsun. Sonra Bir iki kere Alp! Mert! Nerdesiniz amk! diye bağırıyorsun. Koluna bir adam girip \"Birisi fazla kaçırmış galiba\" diyip seni kapına önüne atıyor. ", [" ... "], []),
    Question(" \"Hava soğukmuş.\" diyorsun kafandan, iyi tarafından bakarsan alkolün etkisini azaltıp seni bir nebze canlandırıyor. Eve gitmen gerek ama yakında taksi göremiyorsun. Uzun bir yürüyüş olacak. ", [" Yola koyul. "], []),
    Question(" Eve doğru giderken ara sokaktan bir takım sesler duyuyorsun ve ilgini çekiyor. Can çekişircesini köşeye oturmuş bir adam görmektesin ve adam sana bakarak elini açıyor. ", [" Adama yaklaş. ", " \"Başıma bela almasam iyi olur.\" "], []),
    Question(" Yakınlaştıkça adamın yüzünün yarısının sanki yanmışcasına bozulmuş olduğunu ve ağızından kan geldiğini görüyorsun. Adamın bir şeyler söylemeye takati yok. Ceketinin iç cebinden bir adres çıkartıp sana veriyor. Sen kağıtı anlamaya çalışırken bir parıltı çakıyor ve adam ortadan kayboluyor. ", [" \"Hasiktir lan...\" ", " \"Lan hasiktir...\" "], []),
    Question(" Ne olduğundan bihaber eve gidiyorsun ve gördüğünün sadece bir ilizyon olduğunu varsayarak direkt uyuyorsun.", [" ... "], []),
    Question(" \"Bu saate hırlısı var hırsızı var... e hırlısı var.\" diyip yürürken arkandan bir panelvanın yaklaştığını görüyorsun. \"Bakar mısınız?... Faruk sokağı nerde biliyor musunuz?\" ", [" \"Uhh... Faruk caddesi olabilir mi?\" "], []),
    Question(" Arka kapının açılmasıyla paketlenmen bir oluyor. Birkaç yardım çığlığı atmana fırsat vermeden kafana çuvalı geçiriyorlar." , [" ... "], []),
    Question(" Eve yürürken iş arkadaşlarının arabaya bindiğini görüyorsun. \"Ulan ne vardı da arabayı boşanma sözleşmesine dahil ettin?\" ", [" \"Yapıcak birşey yok tabana kuvvet\" "], []),
    Question(" Bağırış sesiyle uyanıyorsun, kafan leş gibi ağrıyor. Bağırış çağırış yine yan komşudan geliyor, \" 7/24 de kavga etmezsin be!\" diyorsun aklından. ", [" Önünde koca bi hafta sonu var, aslında 17 saat... eksi uyku. >:/ "], []),
    Question(" Kahvaltığını getiren kuryeye para çıkartırken cebinde bir not olduğunu fark ediyorsun \"319/Çifte Ay Yolu...\". Dün geceden kalan hafızan biraz bulanık ", [" \"Allah allah yav... Bi bakalım şuraya ne varmış?\" ", " \"Beni ucuz hikaye yönlendirmeleriyle kandıramazsınız!!!\" "], []),
    Question(" Taksiyle kağıtta yazan adrese gidiyorsun. Biraz Tenha bir yerde büyük bir malikhane. Kapıdan birisi sana doğru yaklaşıp seni selamlıyor. \"Sebebi ziyaretinizi öğrenebilir miyim efendim?\" ", [" Kağıtı uzat " , " \"Sadece geçiyordum\" ", " Beni Haramidere'den Çatapat Ahmet gönderdi! "], []),
    Question(" Adam arkasını dönüp bir uzaklaşıp şaşırmış bir ses tonunda kulaklığına basarak bir şeyler konuşuyor. Şöyle geçin diyerek seni içeri davet ediyor ve kapıdan girdikten sonra önünde iki kişi belirmesiyle paketlenmen bir oluyor. Birkaç yardım çığlığı atmana fırsat vermeden kafana çuvalı geçiriyorlar. " , [" ... "], []),
    Question(" GİRİŞİN SONU ", ["BÖLÜM 1"], []),
    Question("-SON-", ["..."], []),

  ];

  List<Node> Nodes= [] ;

   Tree(){
     int x = 0 ;
     for (var Q in Questions)
     {
       Nodes.add(Node(Q , x));
       x = x+1 ;
     }
     Nodes[0].Addchild([Nodes[1]]) ;
     Nodes[1].Addchild([Nodes[3] , Nodes[2]]);
     Nodes[2].Addchild([Nodes[3] , Nodes[24]]);
     Nodes[3].Addchild( [Nodes[4]]);
     Nodes[4].Addchild([Nodes[5] ]);
     Nodes[5].Addchild([Nodes[6]  , Nodes[18]]);
     Nodes[6].Addchild([Nodes[19] , Nodes[7] , Nodes[8] , Nodes[10]] );
     Nodes[7].Addchild([Nodes[19]]);
     Nodes[8].Addchild( [Nodes[9]]);
     Nodes[9].Addchild([Nodes[9]] );
     Nodes[10].Addchild( [Nodes[11] , Nodes[11]]);
     Nodes[11].Addchild( [Nodes[12]] );
     Nodes[12].Addchild([Nodes[13]]);
     Nodes[13].Addchild([Nodes[14],Nodes[16]]);
     Nodes[14].Addchild([Nodes[15] , Nodes[15]]);
     Nodes[15].Addchild([Nodes[19]]);
     Nodes[16].Addchild( [Nodes[17]] );
     Nodes[17].Addchild([Nodes[23]]);
     Nodes[18].Addchild([Nodes[13]]);
     Nodes[19].Addchild([Nodes[20]]);
     Nodes[20].Addchild( [Nodes[21] , Nodes[24]] );
     Nodes[21].Addchild( [Nodes[22],Nodes[22],Nodes[22]]);
     Nodes[22].Addchild([Nodes[23]]);
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