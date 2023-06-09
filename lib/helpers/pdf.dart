import 'package:flutter/services.dart';
import 'package:orcamento_app/components/card_gasto.dart';
import 'package:orcamento_app/data/gasto_dao.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'save_pdf.dart';

class PDF {
  Future<void> getPDF() async {
    PdfDocument pdf = PdfDocument();
    final page = pdf.pages.add();

    page.graphics.drawString("teste",PdfStandardFont(PdfFontFamily.helvetica, 30),
        bounds: const Rect.fromLTWH(0, 0, 500, 500),
        format: PdfStringFormat(alignment: PdfTextAlignment.center));

    List<int> bytes = await pdf.save();

    pdf.dispose();

    SaveFile().saveAndLaunchFile(bytes, "Relatorio.pdf");
  }

  Future<PdfPageTemplateElement> templateHeader() async {
    final PdfPageTemplateElement headerTemplate = PdfPageTemplateElement(
      const Rect.fromLTWH(0, 0, 500, 100),
    );

    headerTemplate.graphics.drawImage(
        PdfBitmap(await _readImageData("logo-orcamento-app.png")),
        const Rect.fromLTWH(200, 0, 100, 100));

    return headerTemplate;
  }

  void templateTable(PdfPage page) async {
    PdfGrid grid = PdfGrid();

    grid.columns.add(count: 2);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.style.backgroundBrush = PdfBrushes.green;
    header.style.textBrush = PdfBrushes.white;
    header.style.font = PdfStandardFont(PdfFontFamily.helvetica, 30);
    header.cells[0].value = "Nome";
    header.cells[1].value = "Valor";

    PdfGridRow row = grid.rows.add();

    List<CardGasto> gastos = await GastoDao().getAll();

    for (CardGasto gasto in gastos) {
      row = grid.rows.add();
      row.style.font = PdfStandardFont(PdfFontFamily.helvetica, 30);
      row.cells[0].value = gasto.cardNome.toLowerCase();
      row.cells[1].value = gasto.cardValor.toString();
    }

    grid.draw(
      page: page,
      bounds: const Rect.fromLTWH(0, 110, 0, 0),
    );
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
