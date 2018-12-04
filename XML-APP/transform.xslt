<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--xsl:template говорит о том, что тут будет замена. match показывает, к какой части документа это применимо-->
  <xsl:template match="/">
    <!--Внутри шаблона пишем наше преобразование-->

    <html>

      <head>

        <title>Ответ</title>

      </head>

      <body>

        <h4><xsl:value-of select="hash/message"></xsl:value-of></h4>

        <br></br>

        <table border="1">

          <!--Цикл-->
          <xsl:for-each select="hash/content/content">

            <!--Создание переменной-->
            <xsl:variable name="iterator" select="position()"/>

            <tr>

              <th>
                <!--Извлекаем значение из переменной-->
                <xsl:value-of select="$iterator"></xsl:value-of>
              </th>
              <th>
                <!--Извлекаем значение из XML-тега-->
                <xsl:value-of select="fact"></xsl:value-of>
              </th>

            </tr>

          </xsl:for-each>

        </table>

      </body>

    </html>

  </xsl:template>

</xsl:stylesheet>
