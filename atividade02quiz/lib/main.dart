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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'QUIZ'),
    );
  }
}

class Question {
  final String pergunta;
  final List<String> alternativas;
  final int indiceCorreta;
  int? alternativaSelecionada;

  const Question({
    required this.pergunta,
    required this.alternativas,
    required this.indiceCorreta,
    required this.alternativaSelecionada,
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
  int _acertos = 0;
  int _erros = 0;

  final List<Question> _perguntas = const [
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
    Question(
      pergunta: '',
      alternativas: [''],
      indiceCorreta: 2,
      alternativaSelecionada: 10,
    ),
  ];

  void _travarRespota(int index) {
    if (_respondeu) return;
    setState(() {
      _alternativaSelecionada = index;
    });
  }

  void _responderAlternativa() {
    if (_alternativaSelecionada == null) return;

    final acerto =
        _alternativaSelecionada == _perguntas[_perguntaAtual].indiceCorreta;

    setState(() {
      _respondeu = true;
      if (acerto) {
        _acertos++;
      } else {
        _erros++;
      }
    });
  }

  void _proximaPergunta() {
    _perguntaAtual++;
    _alternativaSelecionada = null;
    _respondeu = false;
  }

  @override
  Widget build(BuildContext context) {
    final quizFinalizado = _perguntaAtual >= _perguntas.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
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
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
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
                    onTap: () => _selecionarAlternativa(index),
                    trailing: selecionada
                        ? const Icon(
                        Icons.check_circle, color: Colors.deepPurple)
                        : null,
                  ),
                );
              },
              ),
              ),

              if(_respondeu)
              Padding(
              padding: const EdgeInsets.symmetric(vertical:8),
              child: Text(
              _alternativaSelecionada == pergunta.indiceCorreta
              ? "Resposta correta!" : "Resposta incorreta!",
              style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _alternativaSelecionada == pergunta.indiceCorreta
              ? Colors.green : Colors.red,
              ),
              ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                onPressed: _respondeu ? _proximaPergunta : (_alternativaSelecionada == null ? null : _responder),
              child: Text(_respondeu ? "Próxima Pergunta" : "Responder"),
              ),
              ),
              ],
              );
    }

    Widget _buildResultado(){
              return Center(
                child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
  const Icon(Icons.emoji_events, size: 64, color: Colors.deepPurple),
const SizedBox(height: 16),
Text("Quiz Finalizado!", style: Theme.of(context).textTheme.headlineMedium),
const SizedBox(height: 24),
Text("Pontuação final: $_pontuacao", style: const TextStyle(fontSize: 18)),
Text("Acertos: $_acertos", style: const TextStyle(fontSize: 18, color: Colors.green)),
Text("Erros: $_erros", style: const TextStyle(fontSize: 18, color: Colors.red)),
const SizedBox(height: 32),
ElevatedButton(onPressed: _reiniciarQuiz, child: const Text("Jogar novamente"),),
],
),
);
    }
}
