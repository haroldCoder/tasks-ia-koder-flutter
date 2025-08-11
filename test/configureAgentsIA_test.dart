import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:test/test.dart';

@GenerateMocks([ConfigureAgentsIa])
void main() {
  late ConfigureAgentsIa configureAgentsIa;
  late ModelIA model;
  late List<MessagesIAInterface> messages;

  setUp(() async {
    model = ModelIA.gemmaFree;
    messages = [
      MessagesIAInterface(
          role: "system",
          content:
              "Eres un asistente que mejora textos, devolviendo solo el texto mejorado y mas estructurado."),
      MessagesIAInterface(
          role: "user",
          content:
              "ejora el estilo y la claridad del siguiente texto, devolviendo solo el texto mejorado sin explicaciones: Crear un gestor de texto que permita desarrollar y ver texto en simultaneo.")
    ];

    await dotenv.load();

    configureAgentsIa = ConfigureAgentsIa();
  });

  group('ConfigureAgentsIa Tests without Mock', () {
    test('makeBrain emits response body on successful request', () async {
      Future<Response> futureData = configureAgentsIa.stream.first as Future<Response>;
      await configureAgentsIa.makeBrain(model, messages);

      Response data = await futureData;

      expect(
        data.statusCode,
        equals(200),
      );
    });
  });
}
