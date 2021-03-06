<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="heder.jsp" %>
${daUspeh} ${daGreska}
<header>
    <div class="container">
        <div class="sixteen columns">
            <a href="admin.jsp"><img src="images/logo2.png"/></a>
            <div class="ostalo">
                <div> Dobrodošli, ${osoba.ime}</div>
                <div>Poslednji put ste pristupili: <%=new Date(session.getCreationTime())%></div>
                <div class="logout"> <a href="Logout">Izloguj se.</a> </div>

            </div>
            <div class="main-menu">
                <nav class="mainnav">
                    <ul>
                        <li><a href="admin.jsp">Korisnici</a></li>
                        <li><a href="labaratorije.jsp">Labaratorije</a></li>
                        <li class="active"><a href="artikli.jsp">Artikli</a></li>
                        <li><a href="kompanije.jsp">Kompanije</a></li>
                        <li><a href="pretraga.jsp">Pretraga</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</header>
<div class="container sadrzaj">
    <div class="sixteen columns">   
        <h2> Zatraženi artikli</h2>
        <div id="center">
            <div class="three-thirds column">
                <table>
                    <thead>
                        <tr>
                            <th>ID lab</th>
                            <th>Naziv</th>
                            <th>Model</th>
                            <th>Kategorija</th>
                            <th>Kolicina</th>
                            <th>Zatrazio</th>
                            <th>Dodaj</th>
                            <th>Obrisi</th>
                        </tr>
                    </thead>  
                    <%                                Class.forName("com.mysql.jdbc.Driver");
                        Connection konekcijaz
                                = DriverManager.getConnection("jdbc:mysql://localhost:3306/ip-isl", "root", "");
                        Statement iskazz = konekcijaz.createStatement();
                        String upitz = "SELECT * FROM zahtevi";
                        ResultSet rezultatz = iskazz.executeQuery(upitz);
                    %>
                    <td colspan="10" class="nema"> Nema nijednog zatraženog artikla. </td>
                    <%
                        while (rezultatz.next()) {
                    %>
                    <style>
                        .nema{display:none;}
                    </style>
                    <%
                        String dodaj = "";
                        String obrisi = "";
                        Integer ID = rezultatz.getInt(1);
                        dodaj = "<a href=\"dodajArtikalz.jsp?id=" + ID + "\"><img src=\"images/ch.gif\"></a>";
                        obrisi = "<a href=\"obrisiArtikal?id=" + ID + "\"><img src=\"images/unch.gif\"></a>";

                    %>   
                    <tbody>
                        <tr>
                            <td><%=rezultatz.getString(2)%></td>
                            <td><%=rezultatz.getString(3)%></td>
                            <td><%=rezultatz.getString(4)%></td>
                            <td><%=rezultatz.getString(5)%></td>
                            <td><%=rezultatz.getString(6)%></td>
                            <td><%=rezultatz.getString(7)%></td>
                            <td><%=dodaj%></td>
                            <td><%=obrisi%></td>
                        </tr> 
                    </tbody>
                    <% }%>
                </table>
            </div>
        </div>
    </div>
                <hr />
    <div class="sixteen columns">
        <h2> Dodaj artikal</h2>
        <div id="center">
            <div class="eight columns">
                <div class="formContent">
                    <form name="dodArtikal" class="myForm" method="post" action="DodajArtikal">
                        <p>Naziv artikla:</p>
                        <input type="text" name="naziv" placeholder="Naziv..." class="full-width" />
                        <p>Model:</p>
                        <input type="text" name="model" placeholder="Model..." class="full-width"/>
                        <p>Evidencioni broj:</p>
                        <input type="text" name="evbroj" placeholder="Evidencioni broj..." class="full-width"/>
                        <p>Garancija traje do:</p>
                        <input type="date" name="dagumgar" placeholder="Garancija..." class="full-width"/>
                        <p>Kompanija:</p>
                        
                        <select name="kompanija" class="full-width">
                            <%
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection konekcijaKomp
                                        = DriverManager.getConnection("jdbc:mysql://localhost:3306/ip-isl", "root", "");
                                Statement iskazKomp = konekcijaKomp.createStatement();
                                String upitKomp = "SELECT * FROM kompanija";
                                ResultSet rezultatKomp = iskazKomp.executeQuery(upitKomp);
                                while (rezultatKomp.next()) {
                                    int idkompanije = rezultatKomp.getInt(1);
                                    String kompanija = rezultatKomp.getString(2);
                            %>
                            <option value="<%=idkompanije%>"><%=kompanija%>
                                <%
                                    }
                                %>
                            </option>
                        </select>
                        <p>Datum nabavke:</p>
                        <input type="date" name="datumnab" placeholder="Datum nabavke..." class="full-width"/>
                        <p>Vrednost (din):</p>
                        <input type="text" name="vrednostdin" placeholder="Cena u dinarima..." class="full-width"/>    
                        <p>Labaratorija:</p>
                        <select name="idlabaratorije" class="full-width">
                            <%  Class.forName("com.mysql.jdbc.Driver");
                                Connection konekcija
                                        = DriverManager.getConnection("jdbc:mysql://localhost:3306/ip-isl", "root", "");
                                Statement iskaz = konekcija.createStatement();
                                String upit = "SELECT * FROM labaratorija";
                                ResultSet rezultat = iskaz.executeQuery(upit);
                                while (rezultat.next()) {
                                    int idLabaratorije = rezultat.getInt(1);
                                    String imeLabaratorije = rezultat.getString(2);
                            %>
                            <option value="<%=rezultat.getString(1)%>"><%=rezultat.getString(2)%>  <% }%></option>
                        </select>
                        <p>Kategorija:</p>
                        <select name="kategorija" class="full-width">
                            <option value="osnovna">Osnovna oprema</option>
                            <option value="pomocna">Pomoćna oprema</option>
                        </select> 
                        <input type="submit" class="full-width" value="Dodaj opremu!" >
                    </form>

                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
