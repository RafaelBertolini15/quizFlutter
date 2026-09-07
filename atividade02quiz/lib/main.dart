import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QUIZ',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'QUIZ'),
    );
  }
}

class Question {
  final String pergunta;
  final List<String> alternativas;
  final int indiceCorreta;

  const Question({
    required this.pergunta,
    required this.alternativas,
    required this.indiceCorreta,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _perguntaAtual = 0;
  int? _alternativaSelecionada;
  bool _respondeu = false;

  final List<Question> _perguntas = const [
    Question(
      pergunta: 'Qual linguagem o Flutter usa?',
      alternativas: ['Java', 'Dart', 'Kotlin', 'Swift'],
      indiceCorreta: 1,
    ),
    Question(
      pergunta: 'Quem criou o Flutter?',
      alternativas: ['Meta', 'Apple', 'Google', 'Microsoft'],
      indiceCorreta: 2,
    ),
    Question(
      pergunta: 'O que renderiza a UI no Flutter?',
      alternativas: ['DOM', 'WebView', 'Widgets', 'HTML'],
      indiceCorreta: 2,
    ),
    Question(
      pergunta: 'Qual widget cria uma lista virtualizada?',
      alternativas: ['Column', 'ListView.builder', 'Row', 'Stack'],
      indiceCorreta: 1,
    ),
    Question(
      pergunta: 'O que faz o setState()?',
      alternativas: [
        'Deleta o widget',
        'Reconstrói a UI com novos dados',
        'Cria uma rota',
        'Importa um pacote',
      ],
      indiceCorreta: 1,
    ),
    Question(
      pergunta: 'Qual arquivo é o entry point padrão?',
      alternativas: ['app.dart', 'index.dart', 'main.dart', 'home.dart'],
      indiceCorreta: 2,
    ),
    Question(
      pergunta: 'O que é um StatelessWidget?',
      alternativas: [
        'Widget sem estado interno',
        'Widget com banco de dados',
        'Widget assíncrono',
        'Widget de navegação',
      ],
      indiceCorreta: 0,
    ),
    Question(
      pergunta: 'Qual comando instala uma dependência?',
      alternativas: ['npm install', 'flutter pub add', 'dart install', 'pip install'],
      indiceCorreta: 1,
    ),
    Question(
      pergunta: 'O que significa "final" em Dart?',
      alternativas: [
        'Valor pode mudar sempre',
        'Atribuído uma vez em runtime',
        'É sempre nulo',
        'É uma função',
      ],
      indiceCorreta: 1,
    ),
    Question(
      pergunta: 'Qual arquivo lista as dependências do projeto?',
      alternativas: ['package.json', 'pubspec.yaml', 'build.gradle', 'Podfile'],
      indiceCorreta: 1,
    ),
  ];

  late final List<int?> _respostasSelecionadas =
  List<int?>.filled(_perguntas.length, null);

  void _travarResposta(int index) {
    if (_respondeu) return;
    setState(() {
      _alternativaSelecionada = index;
    });
  }

  void _responderAlternativa() {
    if (_alternativaSelecionada == null) return;
    setState(() {
      _respostasSelecionadas[_perguntaAtual] = _alternativaSelecionada;
      _respondeu = true;
    });
  }

  void _proximaPergunta() {
    setState(() {
      _perguntaAtual++;
      if (_perguntaAtual < _perguntas.length) {
        _alternativaSelecionada = _respostasSelecionadas[_perguntaAtual];
        _respondeu = _alternativaSelecionada != null;
      }
    });
  }

  void _reiniciarQuiz() {
    setState(() {
      _perguntaAtual = 0;
      _alternativaSelecionada = null;
      _respondeu = false;
      for (int i = 0; i < _respostasSelecionadas.length; i++) {
        _respostasSelecionadas[i] = null;
      }
    });
  }

  int get _acertos {
    int total = 0;
    for (int i = 0; i < _perguntas.length; i++) {
      if (_respostasSelecionadas[i] == _perguntas[i].indiceCorreta) total++;
    }
    return total;
  }

  int get _erros {
    int total = 0;
    for (int i = 0; i < _perguntas.length; i++) {
      if (_respostasSelecionadas[i] != null &&
          _respostasSelecionadas[i] != _perguntas[i].indiceCorreta) {
        total++;
      }
    }
    return total;
  }

  int get _pontuacao => _acertos * 10;

  @override
  Widget build(BuildContext context) {
    final quizFinalizado = _perguntaAtual >= _perguntas.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('QUIZ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: quizFinalizado ? _buildResultado() : _buildPergunta(),
      ),
    );
  }

  Widget _buildPergunta() {
    final pergunta = _perguntas[_perguntaAtual];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pergunta ${_perguntaAtual + 1} de ${_perguntas.length}',
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(
          pergunta.pergunta,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),

        Expanded(
          child: ListView.builder(
            itemCount: pergunta.alternativas.length,
            itemBuilder: (context, index) {
              final selecionada = _alternativaSelecionada == index;
              final correta = index == pergunta.indiceCorreta;

              Color? corFundo;
              if (_respondeu) {
                if (correta) {
                  corFundo = Colors.green.shade200;
                } else if (selecionada) {
                  corFundo = Colors.red.shade200;
                }
              } else if (selecionada) {
                corFundo = Colors.deepPurple.shade100;
              }

              return Card(
                color: corFundo,
                child: ListTile(
                  title: Text(pergunta.alternativas[index]),
                  onTap: () => _travarResposta(index),
                  trailing: selecionada
                      ? const Icon(Icons.check_circle, color: Colors.deepPurple)
                      : null,
                ),
              );
            },
          ),
        ),

        if (_respondeu)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              _alternativaSelecionada == pergunta.indiceCorreta
                  ? "Resposta correta!"
                  : "Resposta incorreta!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _alternativaSelecionada == pergunta.indiceCorreta
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _respondeu
                ? _proximaPergunta
                : (_alternativaSelecionada == null ? null : _responderAlternativa),
            child: Text(_respondeu ? "Próxima Pergunta" : "Responder"),
          ),
        ),
      ],
    );
  }

  Widget _buildResultado() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, size: 64, color: Colors.deepPurple),
          const SizedBox(height: 16),
          Text(
            "Quiz Finalizado!",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          Text(
            "Pontuação final: $_pontuacao",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Acertos: $_acertos",
            style: const TextStyle(fontSize: 18, color: Colors.green),
          ),
          Text(
            "Erros: $_erros",
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _reiniciarQuiz,
            child: const Text("Jogar novamente"),
          ),
        ],
      ),
    );
  }
}