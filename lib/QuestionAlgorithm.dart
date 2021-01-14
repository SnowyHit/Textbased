import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key key}) : super(key: key) ;
  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int _counter = 0 ;
  int point = 0 ;
  bool isLoaded = false ;
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
    return  !isLoaded ? Container() : Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  color : Colors.black12,
                  child: Text(
                    "${startRoot(_counter).value.line}" ,
                    textAlign: TextAlign.center,
                  )
              ) ,
              Container(
                  child : Column(
                    children: startRoot(_counter).value.answers.asMap().entries.map<Widget>((answer) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: ((){}),
                            onLongPress: (){
                              setState(() {
                                if(startRoot(_counter).haschildren)
                                  {
                                    point = point ;
                                    _incrementCounter(startRoot(_counter).children[answer.key].index , point) ;
                                  }
                              });

                            },
                            child : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "${answer.value}" ,
                              ),
                            ) ,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              )
            ],
        ),
      ),
    );
  }
}



Node startRoot(int x){
   Node currentNode ;
   Question S001 = new Question(" ZZZZZZZt! Alarmın çalıyor. " , [" Alarmı sustur ve işe git. " , " Alarmı sustur v... "] , [0 , 0 ] ) ;
   Question S002 = new Question(" Telefonun Çalıyor, \"İş Ali\". İçinden \"hasiktir...\" diyorsun. " , ["Aceleyle hazırlanıp işe git!  " , " Siktir et. "] , [0 , 0 ] ) ;
   Question S003 = new Question(" Müdürün günlük fırçasını kayarken her zamanki gibi hayatın anlamını düşünüyorsun. " , [" İşe başla... "] , [0 ] ) ;
   Question S004 = new Question(" Belin ağrıyor... Beyaz yakalı olmanın dünyadaki en iyi iş olmadığını tekrar fark ediyorsun. Neyse ki yarım saat sonra paydos ve yarın tatil diyorsun ama iş arkadaşın mesai olduğunu hatırlatıyor... " , [ "Hayatı sikim..."] , [0 ] ) ;
   Question S005 = new Question(" İş çıkışı arkadaşlarını bara giderken görüyorsun. " , [" \"Bir kaç biradan bir şey olmaz.\" ", " \"Zaten yorgunum bi' de milletle mi uğraşıcam?\" "], []);
   Question S006 = new Question(" Arkadaşlarınla bar yolunu tutuyorsun. Barını neon ışıkları gözünü alıyor \"Vlad\'ın Yeri AmBar\". Saat Kavramı senin için anlamını yitiriyor. Koluna bakıyorsun saat gece yarısını geçmiş hatta iki olmuş. " , [" Dibini görmeyen ana... ", " Laura\'yı ara ve onu çok sevdiğini, seni neden böyle terkedip gittiğini sor... çocuklarına selam söyle. :( ", " \"Siz de mi hep bu bara gelirsiniz?\" ", " \"Siz de mi hep bu bara gelirsiniz?\" ", " \"Galiba eve gitmem gerekiyor\" "], []);
   Question S007 = new Question(" Telefonunu arıyorsun, arıyorsun ama yok. Lan telefon zaten elindeymiş, \"Son tekilayı vurmasamıydım?\" diyorsun ama iş işten çoktan geçmiş. Telefonda Numarayı bulm... ", [" ... "], []);
   Question S008 = new Question(" Kadın ufak bir gülücük atıyor ve birasını yudumlamaya devam ediyor. Sen de gülücükten aldığın gazla devam ediyorsun. sırtından birisi seni dürtüyor. ", [" \"Şu an işim var görmüyor musun!?\" "], []);
   Question S009 = new Question(" Bir daha dürtüyor ve ne var diye arkanı dödüğünde bir ışık hüzmesi görüyorsun. ", [" ... "], []);
   Question S010 = new Question(" Tuvaletin geliyor ve tuvalete gidiyorsun. Bir bar tuvaleti gece 2 de nasıl olması gerekiyorsa öyle, temiz ve mis kokulu. İşini görüp yüzünü yıkıyorsun ve kendine bir daha içmemek için tekrar söz veriyorsun. Geri döndüğünde bir şeyler eksik diyorsun. Arkadaşların yok! Puştlar seni ekmiş gibi. ", [" Aramaya çalış. ", " Siktir et. Eve git. "], []);
   Question S011 = new Question(" İlk önce telefonuna davanıyorsun ama telefonunun şarjının bittiğini fark ediyorsun. Sonra Bir iki kere Alp! Mert! Nerdesiniz amk! diye bağırıyorsun. Koluna bir adam girip \"Birisi fazla kaçırmış galiba\" diyip seni kapına önüne atıyor. ", [" ... "], []);
   Question S012 = new Question(" \"Hava soğukmuş.\" diyorsun kafandan, iyi tarafından bakarsan alkolün etkisini azaltıp seni bir nebze canlandırıyor. Eve gitmen gerek ama yakında taksi göremiyorsun. Uzun bir yürüyüş olacak. ", [" Yola koyul. "], []);
   Question S013 = new Question(" Eve doğru giderken ara sokaktan bir takım sesler duyuyorsun ve ilgini çekiyor. Can çekişircesini köşeye oturmuş bir adam görmektesin ve adam sana bakarak elini açıyor. ", [" Adama yaklaş. ", " \"Başıma bela almasam iyi olur.\" "], []);
   Question S014 = new Question(" Yakınlaştıkça adamın yüzünün yarısının sanki yanmışcasına bozulmuş olduğunu ve ağızından kan geldiğini görüyorsun. Adamın bir şeyler söylemeye takati yok. Ceketinin iç cebinden bir adres çıkartıp sana veriyor. Sen kağıtı anlamaya çalışırken bir parıltı çakıyor ve adam ortadan kayboluyor. ", [" \"Hasiktir lan...\" ", " \"Lan hasiktir...\" "], []);
   Question S015 = new Question(" Ne olduğundan bihaber eve gidiyorsun ve gördüğünün sadece bir ilizyon olduğunu varsayarak direkt uyuyorsun.", [" ... "], []);
   Question S016 = new Question(" \"Bu saate hırlısı var hırsızı var... e hırlısı var.\" diyip yürürken arkandan bir panelvanın yaklaştığını görüyorsun. \"Bakar mısınız?... Faruk sokağı nerde biliyor musunuz?\" ", [" \"Uhh... Faruk caddesi olabilir mi?\" "], []);
   Question S017 = new Question(" Arka kapının açılmasıyla paketlenmen bir oluyor. Birkaç yardım çığlığı atmana fırsat vermeden kafana çuvalı geçiriyorlar." , [" ... "], []);
   Question S018 = new Question(" Eve yürürken iş arkadaşlarının arabaya bindiğini görüyorsun. \"Ulan ne vardı da arabayı boşanma sözleşmesine dahil ettin?\" ", [" \"Yapıcak birşey yok tabana kuvvet\" "], []);
   Question S019 = new Question(" Bağırış sesiyle uyanıyorsun, kafan leş gibi ağrıyor. Bağırış çağırış yine yan komşudan geliyor, \" 7/24 de kavga etmezsin be!\" diyorsun aklından. ", [" Önünde koca bi hafta sonu var, aslında 17 saat... eksi uyku. >:/ "], []);
   Question S020 = new Question(" Kahvaltığını getiren kuryeye para çıkartırken cebinde bir not olduğunu fark ediyorsun \"319/Çifte Ay Yolu...\". Dün geceden kalan hafızan biraz bulanık ", [" \"Allah allah yav... Bi bakalım şuraya ne varmış?\" ", " \"Beni ucuz hikaye yönlendirmeleriyle kandıramazsınız!!!\" "], []);
   Question S021 = new Question(" Taksiyle kağıtta yazan adrese gidiyorsun. Biraz Tenha bir yerde büyük bir malikhane. Kapıdan birisi sana doğru yaklaşıp seni selamlıyor. \"Sebebi ziyaretinizi öğrenebilir miyim efendim?\" ", [" Kağıtı uzat " , " \"Sadece geçiyordum\" ", " Beni Haramidere'den Çatapat Ahmet gönderdi! "], []);
   Question S022 = new Question(" Adam arkasını dönüp bir uzaklaşıp şaşırmış bir ses tonunda kulaklığına basarak bir şeyler konuşuyor. Şöyle geçin diyerek seni içeri davet ediyor ve kapıdan girdikten sonra önünde iki kişi belirmesiyle paketlenmen bir oluyor. Birkaç yardım çığlığı atmana fırsat vermeden kafana çuvalı geçiriyorlar. " , [" ... "], []);
   Question S023 = new Question("GİRİŞİN SONU", ["BÖLÜM 1"], []);
   Question SON1 = new Question("-SON-", ["..."], []);
   Node Son1 = new Node.leaf(SON1 , 9999) ;
   Node N023 = new Node.leaf(S023 , 23);
   Node N022 = new Node(S022 , [N023] , 22);
   Node N021 = new Node(S021 , [N022,N022,N022] , 21);
   Node N020 = new Node(S020 , [N021 , Son1] , 20);
   Node N019 = new Node(S019 , [N020] , 19);
   Node N017 = new Node(S017 , [N023] , 17);
   Node N016 = new Node(S016 , [N017] , 16);
   Node N015 = new Node(S015 , [N019] , 15);
   Node N014 = new Node(S014 , [N015 , N015] , 14);
   Node N013 = new Node(S013 , [N014,N016] , 13);
   Node N018 = new Node(S018 , [N013] , 18);
   Node N012 = new Node(S012 , [N013] , 12);
   Node N011 = new Node(S011 , [N012] , 11);
   Node N010 = new Node(S010 , [N011 , N012] , 10);
   Node N009 = new Node(S009 , [N019] , 9);
   Node N008 = new Node(S008 , [N009] , 8);
   Node N007 = new Node(S007 , [N019] , 7);
   Node N006 = new Node(S006 , [N019 , N007 , N008 , N010] , 6);
   Node N005 = new Node(S005 , [N006 , N018] , 5);
   Node N004 = new Node(S004 , [N005] , 4);
   Node N003 = new Node(S003 , [N004] , 3);
   Node N002 = new Node(S002 , [N003 , Son1] , 2);
   Node N001 = new Node(S001 , [N003 , N002] , 0);
   List<Node> Allnodes= [N001 ,N002 ,N003 ,N003 ,N004 ,N005 ,N006 ,N007 ,N008 ,N009 ,N010 ,N011 ,N012 ,N013 ,N014 ,N015 ,N016 ,N017 ,N018 ,N019 ,N020 ,N021 ,N022 ,N023 , Son1] ;

   for(var node in Allnodes)
     {
       if(node.index == x)
         {
           currentNode = node ;
           print(x);
         }
     }

   return currentNode ;
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
  Node(Question value, List<Node<Question>> children , int index)
  {
    this.index = index ;
    this.value = value ;
    this.children = children ;
    haschildren = true ;
  }
  Node.leaf(Question value , int index)
  {
    this.index = index ;
    this.value = value ;
    haschildren = false ;
  }
}