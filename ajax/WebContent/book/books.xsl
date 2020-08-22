<?xml version="1.0" encoding="UTF-8"?>
<!-- XSLT(Extensible Stylesheet Language Template) : XML 데이타를 변환하기
위한 XML 기반의 언어로 작성된 파서(Parse) -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- output : 변환되어 반환된 결과를 설정하는 엘리먼트 -->
	<xsl:output method="html" encoding="UTF-8"/>
	<!-- template : XML 데이타를 변경하기 위한 정보를 설정하는 상위 엘리먼트 -->
	<!-- => match 속성 : XML 데이타의 루트 엘리먼트 이름을 속성값으로 설정 -->
	<xsl:template match="books">
		<ol>
		<!-- for-each : XML 데이타의 반복 처리를 제공하는 엘리먼트 -->
		<!-- => select 속성 : 반복 처리하기 위한 XML 데이타의 엘리먼트 이름을 속성값으로 설정 -->
		<xsl:for-each select="book">
			<!-- value-of : XML 데이타의 엘리먼트 내용(값)을 제공하는 엘리먼트 -->
			<!-- => select 속성 : 엘리먼트 내용에 대한 XML 데이타의 엘리먼트 이름을 속성값으로 설정 -->
			<li><b><xsl:value-of select="title"/></b>(<xsl:value-of select="author"/>)</li>
		</xsl:for-each>	
		</ol>
	</xsl:template>
</xsl:stylesheet>