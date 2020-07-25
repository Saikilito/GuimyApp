import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:guimyapp/src/Pages/Body/ConsultasMensajerias/ConsultasBody.dart';
import 'package:guimyapp/src/Pages/Body/ConsultasMensajerias/MensajeriaBody.dart';
import 'package:guimyapp/src/Provider/ModelReportConsultasMensajeria.dart';
import 'package:provider/provider.dart';
class ReportarBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60.0,bottom: 50.0),
      color: Colors.grey[300],
      height: double.infinity,
      // child: _CerrarSesion(),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 30.0,),
              Row(children: <Widget>[Icon(Icons.chevron_left),Text("Atrás")],),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Provider.of<ModelReportConsultasMensajerias>(context, listen: false).currentPage = 0;
                      PageController contr =  Provider.of<ModelReportConsultasMensajerias>(context, listen: false).pageViewController;
                      contr.jumpToPage(0);
                      Provider.of<ModelReportConsultasMensajerias>(context, listen: false).pageViewController = contr;
                    },
                    child: _TopIndexPage("Consultas",0)
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<ModelReportConsultasMensajerias>(context, listen: false).currentPage = 1;
                      PageController contr =  Provider.of<ModelReportConsultasMensajerias>(context, listen: false).pageViewController;
                      contr.jumpToPage(1);
                      Provider.of<ModelReportConsultasMensajerias>(context, listen: false).pageViewController = contr;

                    },
                    child: _TopIndexPage("Mensajería",1)
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),

              _PageViewMensajeriaConsultas(),
              SizedBox(height: 15.0,),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageViewMensajeriaConsultas extends StatefulWidget {

  @override
  __PageViewMensajeriaConsultasState createState() => __PageViewMensajeriaConsultasState();
}

class __PageViewMensajeriaConsultasState extends State<_PageViewMensajeriaConsultas> {


  PageController pageViewController = new PageController();

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      // print(pageViewController.page);
      Provider.of<ModelReportConsultasMensajerias>(context, listen: false).currentPage = pageViewController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    pageViewController = Provider.of<ModelReportConsultasMensajerias>(context).pageViewController;
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width-40,
      height: size.height-250,
      child: PageView(
        onPageChanged: (value) {
            Provider.of<ModelReportConsultasMensajerias>(context, listen: false).currentPage = value/1.0;
        },
        scrollDirection: Axis.horizontal,
        controller: pageViewController,
        children: <Widget>[
          ConsultasBody(),
          MensajeriaBody(),

        ],
      ),
    );
  }
}

class _TopIndexPage extends StatelessWidget {
  final String texto;
  final int index;
  _TopIndexPage(this.texto,this.index);
  @override
  Widget build(BuildContext context) {
    double currentPage = Provider.of<ModelReportConsultasMensajerias>(context).currentPage;
    return Column(
      children:<Widget>[
        Text("$texto",style: TextStyle(color: Colors.grey[600],fontSize: 20.0,fontWeight: FontWeight.w800),),
        
        if(currentPage < 0.5)
          SlideInRight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: (index ==0)?Colors.grey[600]:Colors.transparent,
              ),
              height: 5.0,
              width: 50.0,
            ),
          ),
        
        if(currentPage >= 0.5)
          SlideInLeft(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: (index ==1)?Colors.grey[600]:Colors.transparent,
              ),
              height: 5.0,
              width: 50.0,
            ),
          ),
        
      ] 
    );
  }
}
