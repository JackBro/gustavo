--
-- PostgreSQL database dump
--

-- Dumped from database version 9.0.1
-- Dumped by pg_dump version 9.0.1
-- Started on 2013-09-16 12:57:03

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 312 (class 2612 OID 11574)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1504 (class 1259 OID 16393)
-- Dependencies: 6
-- Name: best_price; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE best_price (
    id bigint NOT NULL,
    version bigint NOT NULL,
    currency character varying(255) NOT NULL,
    day date NOT NULL,
    price numeric(19,2) NOT NULL,
    query_id bigint NOT NULL
);


ALTER TABLE public.best_price OWNER TO postgres;

--
-- TOC entry 1507 (class 1259 OID 16410)
-- Dependencies: 6
-- Name: exchange_rate; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE exchange_rate (
    id bigint NOT NULL,
    version bigint NOT NULL,
    currency character varying(255) NOT NULL,
    day date NOT NULL,
    rate numeric(19,2) NOT NULL
);


ALTER TABLE public.exchange_rate OWNER TO postgres;

--
-- TOC entry 1505 (class 1259 OID 16396)
-- Dependencies: 6
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 1802 (class 0 OID 0)
-- Dependencies: 1505
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hibernate_sequence', 1201, true);


--
-- TOC entry 1506 (class 1259 OID 16398)
-- Dependencies: 6
-- Name: query; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE query (
    id bigint NOT NULL,
    version bigint NOT NULL,
    content character varying(255) NOT NULL
);


ALTER TABLE public.query OWNER TO postgres;

--
-- TOC entry 1794 (class 0 OID 16393)
-- Dependencies: 1504
-- Data for Name: best_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY best_price (id, version, currency, day, price, query_id) FROM stdin;
593	0	USD	2013-09-12	158.00	504
594	0	USD	2013-09-12	260.00	505
595	0	USD	2013-09-12	1366.00	506
596	0	USD	2013-09-12	1798.00	510
597	0	USD	2013-09-12	1359.00	507
598	0	USD	2013-09-12	1169.00	508
599	0	USD	2013-09-12	1989.00	509
600	0	USD	2013-09-12	1798.00	511
601	0	USD	2013-09-12	643.00	512
602	0	USD	2013-09-12	566.00	513
603	0	USD	2013-09-12	602.00	587
604	0	USD	2013-09-12	496.00	514
605	0	USD	2013-09-12	1221.00	515
606	0	USD	2013-09-12	1221.00	516
607	0	USD	2013-09-12	1087.00	517
608	0	USD	2013-09-12	1186.00	518
609	0	USD	2013-09-12	1185.00	519
610	0	USD	2013-09-12	1045.00	520
611	0	USD	2013-09-12	1327.00	521
612	0	USD	2013-09-12	1328.00	522
613	0	USD	2013-09-12	1310.00	523
614	0	USD	2013-09-12	1121.00	524
615	0	USD	2013-09-12	684.00	525
616	0	USD	2013-09-12	1102.00	526
617	0	USD	2013-09-12	1659.00	567
618	0	USD	2013-09-12	1191.00	527
619	0	USD	2013-09-12	1092.00	528
620	0	USD	2013-09-12	992.00	529
621	0	USD	2013-09-12	871.00	530
622	0	USD	2013-09-12	873.00	531
623	0	USD	2013-09-12	914.00	532
624	0	USD	2013-09-12	506.00	533
625	0	USD	2013-09-12	411.00	534
626	0	USD	2013-09-12	379.00	535
627	0	USD	2013-09-12	697.00	536
628	0	USD	2013-09-12	563.00	537
629	0	USD	2013-09-12	490.00	538
630	0	USD	2013-09-12	1290.00	539
631	0	USD	2013-09-12	1229.00	540
632	0	USD	2013-09-12	1091.00	541
633	0	USD	2013-09-12	1163.00	542
634	0	USD	2013-09-12	1166.00	543
635	0	USD	2013-09-12	1026.00	544
636	0	USD	2013-09-12	1160.00	545
637	0	USD	2013-09-12	1118.00	546
638	0	USD	2013-09-12	963.00	547
639	0	USD	2013-09-12	1148.00	548
640	0	USD	2013-09-12	1054.00	549
641	0	USD	2013-09-12	963.00	550
642	0	USD	2013-09-12	1514.00	551
643	0	USD	2013-09-12	1517.00	552
644	0	USD	2013-09-12	1307.00	553
645	0	USD	2013-09-12	1400.00	554
646	0	USD	2013-09-12	1293.00	555
647	0	USD	2013-09-12	1181.00	556
648	0	USD	2013-09-12	1178.00	557
649	0	USD	2013-09-12	1176.00	558
650	0	USD	2013-09-12	1037.00	559
651	0	USD	2013-09-12	1256.00	560
652	0	USD	2013-09-12	1257.00	561
653	0	USD	2013-09-12	1052.00	562
654	0	USD	2013-09-12	1376.00	563
655	0	USD	2013-09-12	1208.00	564
656	0	USD	2013-09-12	1408.00	565
657	0	USD	2013-09-12	1902.00	566
658	0	USD	2013-09-12	1515.00	568
659	0	USD	2013-09-12	1206.00	569
660	0	USD	2013-09-12	1209.00	570
661	0	USD	2013-09-12	1089.00	571
662	0	USD	2013-09-12	1482.00	572
663	0	USD	2013-09-12	1462.00	573
664	0	USD	2013-09-12	1353.00	574
665	0	USD	2013-09-12	1224.00	575
666	0	USD	2013-09-12	1225.00	576
667	0	USD	2013-09-12	1107.00	577
668	0	USD	2013-09-12	1271.00	578
669	0	USD	2013-09-12	1185.00	579
670	0	USD	2013-09-12	1047.00	580
671	0	USD	2013-09-12	1197.00	581
672	0	USD	2013-09-12	1147.00	582
673	0	USD	2013-09-12	1190.00	583
674	0	USD	2013-09-12	1163.00	584
675	0	USD	2013-09-12	1146.00	585
676	0	USD	2013-09-12	1023.00	586
677	0	USD	2013-09-12	582.00	588
678	0	USD	2013-09-12	475.00	589
679	0	USD	2013-09-12	1085.00	590
680	0	USD	2013-09-12	958.00	591
681	0	USD	2013-09-12	1111.00	592
682	0	USD	2013-09-13	260.00	505
683	0	USD	2013-09-13	1366.00	506
684	0	USD	2013-09-13	1359.00	507
685	0	USD	2013-09-13	1170.00	508
686	0	USD	2013-09-13	2089.00	509
687	0	USD	2013-09-13	1798.00	510
688	0	USD	2013-09-13	1798.00	511
689	0	USD	2013-09-13	643.00	512
690	0	USD	2013-09-13	566.00	513
691	0	USD	2013-09-13	496.00	514
692	0	USD	2013-09-13	1221.00	515
693	0	USD	2013-09-13	1221.00	516
694	0	USD	2013-09-13	1087.00	517
695	0	USD	2013-09-13	1186.00	518
696	0	USD	2013-09-13	1185.00	519
697	0	USD	2013-09-13	1045.00	520
698	0	USD	2013-09-13	1327.00	521
699	0	USD	2013-09-13	1328.00	522
700	0	USD	2013-09-13	1310.00	523
701	0	USD	2013-09-13	158.00	504
702	0	USD	2013-09-13	1121.00	524
703	0	USD	2013-09-13	684.00	525
704	0	USD	2013-09-13	1112.00	526
705	0	USD	2013-09-13	1191.00	527
706	0	USD	2013-09-13	1092.00	528
707	0	USD	2013-09-13	992.00	529
708	0	USD	2013-09-13	871.00	530
709	0	USD	2013-09-13	873.00	531
710	0	USD	2013-09-13	914.00	532
711	0	USD	2013-09-13	506.00	533
712	0	USD	2013-09-13	411.00	534
713	0	USD	2013-09-13	379.00	535
714	0	USD	2013-09-13	697.00	536
715	0	USD	2013-09-13	563.00	537
716	0	USD	2013-09-13	490.00	538
717	0	USD	2013-09-13	1290.00	539
718	0	USD	2013-09-13	1229.00	540
719	0	USD	2013-09-13	1091.00	541
720	0	USD	2013-09-13	1163.00	542
721	0	USD	2013-09-13	1166.00	543
722	0	USD	2013-09-13	1026.00	544
723	0	USD	2013-09-13	1160.00	545
724	0	USD	2013-09-13	1121.00	546
725	0	USD	2013-09-13	963.00	547
726	0	USD	2013-09-13	1148.00	548
727	0	USD	2013-09-13	1054.00	549
728	0	USD	2013-09-13	963.00	550
729	0	USD	2013-09-13	1514.00	551
730	0	USD	2013-09-13	1517.00	552
731	0	USD	2013-09-13	1307.00	553
732	0	USD	2013-09-13	1400.00	554
733	0	USD	2013-09-13	1293.00	555
734	0	USD	2013-09-13	1183.00	556
735	0	USD	2013-09-13	1178.00	557
736	0	USD	2013-09-13	1176.00	558
737	0	USD	2013-09-13	1037.00	559
738	0	USD	2013-09-13	1256.00	560
739	0	USD	2013-09-13	1257.00	561
740	0	USD	2013-09-13	1052.00	562
741	0	USD	2013-09-13	1376.00	563
742	0	USD	2013-09-13	1208.00	564
743	0	USD	2013-09-13	1408.00	565
744	0	USD	2013-09-13	1902.00	566
745	0	USD	2013-09-13	1659.00	567
746	0	USD	2013-09-13	1515.00	568
747	0	USD	2013-09-13	1206.00	569
748	0	USD	2013-09-13	1209.00	570
749	0	USD	2013-09-13	1089.00	571
750	0	USD	2013-09-13	1495.00	572
751	0	USD	2013-09-13	1485.00	573
752	0	USD	2013-09-13	1353.00	574
753	0	USD	2013-09-13	1224.00	575
754	0	USD	2013-09-13	1225.00	576
755	0	USD	2013-09-13	1107.00	577
756	0	USD	2013-09-13	1271.00	578
757	0	USD	2013-09-13	1185.00	579
758	0	USD	2013-09-13	1047.00	580
759	0	USD	2013-09-13	1207.00	581
760	0	USD	2013-09-13	1122.00	582
761	0	USD	2013-09-13	1190.00	583
762	0	USD	2013-09-13	1163.00	584
763	0	USD	2013-09-13	1146.00	585
764	0	USD	2013-09-13	1023.00	586
765	0	USD	2013-09-13	602.00	587
766	0	USD	2013-09-13	582.00	588
767	0	USD	2013-09-13	475.00	589
771	0	USD	2013-09-13	1085.00	590
772	0	USD	2013-09-13	988.00	591
773	0	USD	2013-09-13	1111.00	592
774	0	USD	2013-09-13	676.00	768
775	0	USD	2013-09-13	581.00	769
776	0	USD	2013-09-13	549.00	770
777	0	USD	2013-09-06	1286.00	543
778	0	USD	2013-09-06	413.00	534
779	0	USD	2013-09-06	1794.00	552
780	0	USD	2013-09-06	1343.00	522
781	0	USD	2013-09-06	1383.00	564
782	0	USD	2013-09-06	1209.00	570
783	0	USD	2013-09-06	653.00	537
784	0	USD	2013-09-06	1410.00	555
785	0	USD	2013-09-06	908.00	531
786	0	USD	2013-09-06	674.00	525
787	0	USD	2013-09-06	1312.00	540
788	0	USD	2013-09-06	1070.00	528
789	0	USD	2013-09-06	1284.00	519
790	0	USD	2013-09-06	1353.00	561
791	0	USD	2013-09-06	1226.00	558
792	0	USD	2013-09-06	2129.00	567
793	0	USD	2013-09-06	1273.00	516
794	0	USD	2013-09-06	1372.00	546
795	0	USD	2013-09-06	1104.00	549
796	0	USD	2013-09-06	1267.00	542
797	0	USD	2013-09-06	336.00	504
798	0	USD	2013-09-06	583.00	533
799	0	USD	2013-09-06	1512.00	551
800	0	USD	2013-09-06	1346.00	521
801	0	USD	2013-09-06	1411.00	563
802	0	USD	2013-09-06	1699.00	569
803	0	USD	2013-09-06	697.00	536
804	0	USD	2013-09-06	1488.00	554
805	0	USD	2013-09-06	871.00	530
806	0	USD	2013-09-06	1116.00	524
807	0	USD	2013-09-06	1397.00	539
808	0	USD	2013-09-06	1236.00	527
809	0	USD	2013-09-06	1431.00	518
810	0	USD	2013-09-06	1169.00	560
811	0	USD	2013-09-06	1305.00	557
812	0	USD	2013-09-06	2271.00	566
813	0	USD	2013-09-06	1220.00	515
814	0	USD	2013-09-06	1344.00	545
815	0	USD	2013-09-06	1219.00	548
816	0	USD	2013-09-09	2314.00	510
817	0	USD	2013-09-09	1168.00	543
818	0	USD	2013-09-09	1855.00	573
819	0	USD	2013-09-09	556.00	513
820	0	USD	2013-09-09	412.00	534
821	0	USD	2013-09-09	1576.00	552
822	0	USD	2013-09-09	1343.00	522
823	0	USD	2013-09-09	1374.00	564
824	0	USD	2013-09-09	1209.00	570
825	0	USD	2013-09-09	653.00	537
826	0	USD	2013-09-09	1371.00	555
827	0	USD	2013-09-09	942.00	531
828	0	USD	2013-09-09	963.00	525
829	0	USD	2013-09-09	1369.00	540
830	0	USD	2013-09-09	1077.00	528
831	0	USD	2013-09-09	1235.00	519
832	0	USD	2013-09-09	1420.00	561
833	0	USD	2013-09-09	1176.00	558
834	0	USD	2013-09-09	2129.00	567
835	0	USD	2013-09-09	1297.00	516
836	0	USD	2013-09-09	1372.00	546
837	0	USD	2013-09-09	1104.00	549
838	0	USD	2013-09-09	2188.00	509
839	0	USD	2013-09-09	1385.00	542
840	0	USD	2013-09-09	1482.00	572
841	0	USD	2013-09-09	643.00	512
842	0	USD	2013-09-09	336.00	504
843	0	USD	2013-09-09	648.00	533
844	0	USD	2013-09-09	2023.00	551
845	0	USD	2013-09-09	1346.00	521
846	0	USD	2013-09-09	1475.00	563
847	0	USD	2013-09-09	1775.00	569
848	0	USD	2013-09-09	697.00	536
849	0	USD	2013-09-09	1488.00	554
850	0	USD	2013-09-09	871.00	530
851	0	USD	2013-09-09	1116.00	524
852	0	USD	2013-09-09	1397.00	539
853	0	USD	2013-09-09	1216.00	527
854	0	USD	2013-09-09	1352.00	518
855	0	USD	2013-09-09	1593.00	560
856	0	USD	2013-09-09	1393.00	557
857	0	USD	2013-09-09	274.00	505
858	0	USD	2013-09-09	2271.00	566
859	0	USD	2013-09-09	1464.00	515
860	0	USD	2013-09-09	1344.00	545
861	0	USD	2013-09-09	1354.00	548
862	0	USD	2013-09-09	1938.00	511
863	0	USD	2013-09-09	486.00	514
864	0	USD	2013-09-09	1113.00	517
865	0	USD	2013-09-10	1797.00	510
866	0	USD	2013-09-10	1168.00	543
867	0	USD	2013-09-10	1462.00	573
868	0	USD	2013-09-10	556.00	513
869	0	USD	2013-09-10	1224.00	576
870	0	USD	2013-09-10	411.00	534
871	0	USD	2013-09-10	1515.00	552
872	0	USD	2013-09-10	1327.00	522
873	0	USD	2013-09-10	1271.00	564
874	0	USD	2013-09-10	1208.00	570
875	0	USD	2013-09-10	563.00	537
876	0	USD	2013-09-10	1146.00	585
877	0	USD	2013-09-10	1291.00	555
878	0	USD	2013-09-10	873.00	531
879	0	USD	2013-09-10	674.00	525
880	0	USD	2013-09-10	1228.00	540
881	0	USD	2013-09-10	1070.00	528
882	0	USD	2013-09-10	958.00	591
883	0	USD	2013-09-10	1185.00	519
884	0	USD	2013-09-10	1257.00	561
885	0	USD	2013-09-10	1176.00	558
886	0	USD	2013-09-10	572.00	588
887	0	USD	2013-09-10	1092.00	582
888	0	USD	2013-09-10	1656.00	567
889	0	USD	2013-09-10	1221.00	516
890	0	USD	2013-09-10	1181.00	546
891	0	USD	2013-09-10	1053.00	549
892	0	USD	2013-09-10	1185.00	579
893	0	USD	2013-09-10	2101.00	509
894	0	USD	2013-09-10	1166.00	542
895	0	USD	2013-09-10	1459.00	572
896	0	USD	2013-09-10	643.00	512
897	0	USD	2013-09-10	158.00	504
898	0	USD	2013-09-10	1224.00	575
899	0	USD	2013-09-10	506.00	533
900	0	USD	2013-09-10	1512.00	551
901	0	USD	2013-09-10	1326.00	521
902	0	USD	2013-09-10	1346.00	563
903	0	USD	2013-09-10	1206.00	569
904	0	USD	2013-09-10	697.00	536
905	0	USD	2013-09-10	1163.00	584
906	0	USD	2013-09-10	1356.00	554
907	0	USD	2013-09-10	871.00	530
908	0	USD	2013-09-10	976.00	524
909	0	USD	2013-09-10	1332.00	539
910	0	USD	2013-09-10	1191.00	527
911	0	USD	2013-09-10	976.00	590
912	0	USD	2013-09-10	1186.00	518
913	0	USD	2013-09-10	1255.00	560
914	0	USD	2013-09-10	1177.00	557
915	0	USD	2013-09-10	261.00	505
916	0	USD	2013-09-10	592.00	587
917	0	USD	2013-09-10	1167.00	581
918	0	USD	2013-09-10	1897.00	566
919	0	USD	2013-09-10	1220.00	515
920	0	USD	2013-09-10	1179.00	545
921	0	USD	2013-09-10	1148.00	548
922	0	USD	2013-09-10	1228.00	578
923	0	USD	2013-09-10	1703.00	511
924	0	USD	2013-09-10	1028.00	544
925	0	USD	2013-09-10	1353.00	574
926	0	USD	2013-09-10	486.00	514
927	0	USD	2013-09-10	1107.00	577
928	0	USD	2013-09-10	379.00	535
929	0	USD	2013-09-10	1305.00	553
930	0	USD	2013-09-10	1199.00	523
931	0	USD	2013-09-10	1378.00	565
932	0	USD	2013-09-10	1089.00	571
933	0	USD	2013-09-10	480.00	538
934	0	USD	2013-09-10	1023.00	586
935	0	USD	2013-09-10	1179.00	556
936	0	USD	2013-09-10	914.00	532
937	0	USD	2013-09-10	1037.00	526
938	0	USD	2013-09-10	992.00	529
939	0	USD	2013-09-10	1155.00	592
940	0	USD	2013-09-10	1094.00	562
941	0	USD	2013-09-10	465.00	589
942	0	USD	2013-09-10	1283.00	583
943	0	USD	2013-09-10	1510.00	568
944	0	USD	2013-09-10	1087.00	517
945	0	USD	2013-09-10	1122.00	547
946	0	USD	2013-09-10	1053.00	550
947	0	USD	2013-09-11	1798.00	510
948	0	USD	2013-09-11	1168.00	543
949	0	USD	2013-09-11	1462.00	573
950	0	USD	2013-09-11	556.00	513
951	0	USD	2013-09-11	1225.00	576
952	0	USD	2013-09-11	412.00	534
953	0	USD	2013-09-11	1517.00	552
954	0	USD	2013-09-11	1328.00	522
955	0	USD	2013-09-11	1188.00	564
956	0	USD	2013-09-11	1209.00	570
957	0	USD	2013-09-11	563.00	537
958	0	USD	2013-09-11	1146.00	585
959	0	USD	2013-09-11	1293.00	555
960	0	USD	2013-09-11	873.00	531
961	0	USD	2013-09-11	674.00	525
962	0	USD	2013-09-11	1229.00	540
963	0	USD	2013-09-11	985.00	528
964	0	USD	2013-09-11	958.00	591
965	0	USD	2013-09-11	1185.00	519
966	0	USD	2013-09-11	1257.00	561
967	0	USD	2013-09-11	1176.00	558
968	0	USD	2013-09-11	572.00	588
969	0	USD	2013-09-11	1049.00	582
970	0	USD	2013-09-11	1659.00	567
971	0	USD	2013-09-11	1221.00	516
972	0	USD	2013-09-11	1463.00	507
973	0	USD	2013-09-11	1149.00	546
974	0	USD	2013-09-11	1054.00	549
975	0	USD	2013-09-11	1185.00	579
976	0	USD	2013-09-11	2102.00	509
977	0	USD	2013-09-11	1166.00	542
978	0	USD	2013-09-11	1460.00	572
979	0	USD	2013-09-11	643.00	512
980	0	USD	2013-09-11	158.00	504
981	0	USD	2013-09-11	1224.00	575
982	0	USD	2013-09-11	506.00	533
983	0	USD	2013-09-11	1514.00	551
984	0	USD	2013-09-11	1327.00	521
985	0	USD	2013-09-11	1263.00	563
986	0	USD	2013-09-11	1206.00	569
987	0	USD	2013-09-11	697.00	536
988	0	USD	2013-09-11	1163.00	584
989	0	USD	2013-09-11	1400.00	554
990	0	USD	2013-09-11	871.00	530
991	0	USD	2013-09-11	976.00	524
992	0	USD	2013-09-11	1383.00	539
993	0	USD	2013-09-11	1104.00	527
994	0	USD	2013-09-11	976.00	590
995	0	USD	2013-09-11	1240.00	518
996	0	USD	2013-09-11	1256.00	560
997	0	USD	2013-09-11	1237.00	557
998	0	USD	2013-09-11	260.00	505
999	0	USD	2013-09-11	592.00	587
1000	0	USD	2013-09-11	1167.00	581
1001	0	USD	2013-09-11	1902.00	566
1002	0	USD	2013-09-11	1221.00	515
1003	0	USD	2013-09-11	1428.00	506
1004	0	USD	2013-09-11	1170.00	545
1005	0	USD	2013-09-11	1148.00	548
1006	0	USD	2013-09-11	1271.00	578
1007	0	USD	2013-09-11	1798.00	511
1008	0	USD	2013-09-11	1028.00	544
1009	0	USD	2013-09-11	1353.00	574
1010	0	USD	2013-09-11	486.00	514
1011	0	USD	2013-09-11	1107.00	577
1012	0	USD	2013-09-11	379.00	535
1013	0	USD	2013-09-11	1307.00	553
1014	0	USD	2013-09-11	1199.00	523
1015	0	USD	2013-09-11	1358.00	565
1016	0	USD	2013-09-11	1089.00	571
1017	0	USD	2013-09-11	480.00	538
1018	0	USD	2013-09-11	1033.00	586
1019	0	USD	2013-09-11	1181.00	556
1020	0	USD	2013-09-11	914.00	532
1021	0	USD	2013-09-11	1042.00	526
1022	0	USD	2013-09-11	992.00	529
1023	0	USD	2013-09-11	1149.00	592
1024	0	USD	2013-09-11	1095.00	562
1025	0	USD	2013-09-11	465.00	589
1026	0	USD	2013-09-11	1290.00	583
1027	0	USD	2013-09-11	1515.00	568
1028	0	USD	2013-09-11	1087.00	517
1029	0	USD	2013-09-11	1169.00	508
1030	0	USD	2013-09-11	963.00	547
1031	0	USD	2013-09-11	963.00	550
1032	0	USD	2013-09-16	158.00	504
1033	0	USD	2013-09-16	213.00	505
1034	0	USD	2013-09-16	1366.00	506
1035	0	USD	2013-09-16	1358.00	507
1036	0	USD	2013-09-16	1170.00	508
1037	0	USD	2013-09-16	2461.00	509
1038	0	USD	2013-09-16	1798.00	510
1039	0	USD	2013-09-16	1798.00	511
1040	0	USD	2013-09-16	643.00	512
1041	0	USD	2013-09-16	566.00	513
1042	0	USD	2013-09-16	496.00	514
1043	0	USD	2013-09-16	1264.00	515
1044	0	USD	2013-09-16	1267.00	516
1045	0	USD	2013-09-16	1084.00	517
1046	0	USD	2013-09-16	1186.00	518
1047	0	USD	2013-09-16	1185.00	519
1048	0	USD	2013-09-16	1045.00	520
1049	0	USD	2013-09-16	1327.00	521
1050	0	USD	2013-09-16	1328.00	522
1051	0	USD	2013-09-16	1310.00	523
1052	0	USD	2013-09-16	1041.00	524
1053	0	USD	2013-09-16	884.00	525
1054	0	USD	2013-09-16	1112.00	526
1055	0	USD	2013-09-16	1061.00	527
1056	0	USD	2013-09-16	1064.00	528
1057	0	USD	2013-09-16	992.00	529
1058	0	USD	2013-09-16	871.00	530
1059	0	USD	2013-09-16	873.00	531
1060	0	USD	2013-09-16	914.00	532
1061	0	USD	2013-09-16	506.00	533
1062	0	USD	2013-09-16	412.00	534
1063	0	USD	2013-09-16	379.00	535
1064	0	USD	2013-09-16	697.00	536
1065	0	USD	2013-09-16	608.00	537
1066	0	USD	2013-09-16	515.00	538
1067	0	USD	2013-09-16	1290.00	539
1068	0	USD	2013-09-16	1281.00	540
1069	0	USD	2013-09-16	1091.00	541
1070	0	USD	2013-09-16	1163.00	542
1071	0	USD	2013-09-16	1166.00	543
1072	0	USD	2013-09-16	1026.00	544
1073	0	USD	2013-09-16	1160.00	545
1074	0	USD	2013-09-16	1124.00	546
1075	0	USD	2013-09-16	963.00	547
1076	0	USD	2013-09-16	1148.00	548
1077	0	USD	2013-09-16	1054.00	549
1078	0	USD	2013-09-16	963.00	550
1079	0	USD	2013-09-16	1514.00	551
1080	0	USD	2013-09-16	1517.00	552
1081	0	USD	2013-09-16	1307.00	553
1082	0	USD	2013-09-16	1400.00	554
1083	0	USD	2013-09-16	1293.00	555
1084	0	USD	2013-09-16	1183.00	556
1085	0	USD	2013-09-16	1178.00	557
1086	0	USD	2013-09-16	1176.00	558
1126	0	USD	2013-09-16	1037.00	559
1127	0	USD	2013-09-16	1306.00	560
1128	0	USD	2013-09-16	1275.00	561
1129	0	USD	2013-09-16	1095.00	562
1130	0	USD	2013-09-16	1331.00	563
1131	0	USD	2013-09-16	1118.00	564
1132	0	USD	2013-09-16	1408.00	565
1133	0	USD	2013-09-16	1902.00	566
1134	0	USD	2013-09-16	1659.00	567
1135	0	USD	2013-09-16	1515.00	568
1136	0	USD	2013-09-16	1365.00	569
1137	0	USD	2013-09-16	1368.00	570
1138	0	USD	2013-09-16	1248.00	571
1139	0	USD	2013-09-16	1495.00	572
1140	0	USD	2013-09-16	1505.00	573
1141	0	USD	2013-09-16	1353.00	574
1142	0	USD	2013-09-16	1383.00	575
1143	0	USD	2013-09-16	1226.00	576
1144	0	USD	2013-09-16	1086.00	577
1145	0	USD	2013-09-16	1289.00	578
1146	0	USD	2013-09-16	1231.00	579
1147	0	USD	2013-09-16	1047.00	580
1148	0	USD	2013-09-16	1197.00	581
1149	0	USD	2013-09-16	1092.00	582
1150	0	USD	2013-09-16	1190.00	583
1151	0	USD	2013-09-16	1163.00	584
1152	0	USD	2013-09-16	1146.00	585
1153	0	USD	2013-09-16	1023.00	586
1154	0	USD	2013-09-16	582.00	587
1155	0	USD	2013-09-16	563.00	588
1156	0	USD	2013-09-16	475.00	589
1157	0	USD	2013-09-16	1085.00	590
1158	0	USD	2013-09-16	958.00	591
1159	0	USD	2013-09-16	1111.00	592
1160	0	USD	2013-09-16	676.00	768
1161	0	USD	2013-09-16	581.00	769
1162	0	USD	2013-09-16	549.00	770
1163	0	USD	2013-09-16	253.00	1087
1164	0	USD	2013-09-16	1208.00	1088
1165	0	USD	2013-09-16	1174.00	1089
1166	0	USD	2013-09-16	1035.00	1090
1167	0	USD	2013-09-16	1032.00	1091
1168	0	USD	2013-09-16	1277.00	1092
1169	0	USD	2013-09-16	1291.00	1093
1170	0	USD	2013-09-16	1101.00	1094
1171	0	USD	2013-09-16	1098.00	1095
1172	0	USD	2013-09-16	615.00	1096
1173	0	USD	2013-09-16	1142.00	1097
1174	0	USD	2013-09-16	2196.00	1098
1175	0	USD	2013-09-16	594.00	1099
1176	0	USD	2013-09-16	1107.00	1100
1177	0	USD	2013-09-16	1042.00	1101
1178	0	USD	2013-09-16	1308.00	1102
1179	0	USD	2013-09-16	967.00	1103
1180	0	USD	2013-09-16	942.00	1104
1181	0	USD	2013-09-16	851.00	1105
1182	0	USD	2013-09-16	446.00	1106
1183	0	USD	2013-09-16	488.00	1107
1184	0	USD	2013-09-16	1175.00	1108
1185	0	USD	2013-09-16	1024.00	1109
1186	0	USD	2013-09-16	983.00	1110
1187	0	USD	2013-09-16	982.00	1111
1188	0	USD	2013-09-16	1445.00	1112
1189	0	USD	2013-09-16	1155.00	1113
1190	0	USD	2013-09-16	1035.00	1114
1191	0	USD	2013-09-16	1060.00	1115
1192	0	USD	2013-09-16	1225.00	1116
1193	0	USD	2013-09-16	1657.00	1117
1194	0	USD	2013-09-16	1256.00	1118
1195	0	USD	2013-09-16	1384.00	1119
1196	0	USD	2013-09-16	1083.00	1120
1197	0	USD	2013-09-16	1044.00	1121
1198	0	USD	2013-09-16	1172.00	1122
1199	0	USD	2013-09-16	1021.00	1123
1200	0	USD	2013-09-16	423.00	1124
1201	0	USD	2013-09-16	1001.00	1125
\.


--
-- TOC entry 1796 (class 0 OID 16410)
-- Dependencies: 1507
-- Data for Name: exchange_rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY exchange_rate (id, version, currency, day, rate) FROM stdin;
1	0	BRL	2013-09-13	2.27
\.


--
-- TOC entry 1795 (class 0 OID 16398)
-- Dependencies: 1506
-- Data for Name: query; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY query (id, version, content) FROM stdin;
504	0	GYN;BSB;07/02/2014 15:00;09/02/2014 23:59\nBSB;GYN;01/03/2014 12:00;05/03/2014 23:59\n
505	0	GYN;SAO;07/02/2014 15:00;09/02/2014 23:59\nSAO;GYN;01/03/2014 12:00;05/03/2014 23:59\n
506	0	GYN;YEA;07/02/2014 15:00;09/02/2014 23:59\nYEA;GYN;01/03/2014 12:00;05/03/2014 23:59\n
507	0	BSB;YEA;07/02/2014 15:00;09/02/2014 23:59\nYEA;BSB;01/03/2014 12:00;05/03/2014 23:59\n
508	0	SAO;YEA;07/02/2014 15:00;09/02/2014 23:59\nYEA;SAO;01/03/2014 12:00;05/03/2014 23:59\n
509	0	GYN;AKL;07/02/2014 15:00;09/02/2014 23:59\nAKL;GYN;01/03/2014 12:00;05/03/2014 23:59\n
510	0	BSB;AKL;07/02/2014 15:00;09/02/2014 23:59\nAKL;BSB;01/03/2014 12:00;05/03/2014 23:59\n
511	0	SAO;AKL;07/02/2014 15:00;09/02/2014 23:59\nAKL;SAO;01/03/2014 12:00;05/03/2014 23:59\n
512	0	GYN;BOG;07/02/2014 15:00;09/02/2014 23:59\nBOG;GYN;01/03/2014 12:00;05/03/2014 23:59\n
513	0	BSB;BOG;07/02/2014 15:00;09/02/2014 23:59\nBOG;BSB;01/03/2014 12:00;05/03/2014 23:59\n
514	0	SAO;BOG;07/02/2014 15:00;09/02/2014 23:59\nBOG;SAO;01/03/2014 12:00;05/03/2014 23:59\n
515	0	GYN;VIE;07/02/2014 15:00;09/02/2014 23:59\nVIE;GYN;01/03/2014 12:00;05/03/2014 23:59\n
516	0	BSB;VIE;07/02/2014 15:00;09/02/2014 23:59\nVIE;BSB;01/03/2014 12:00;05/03/2014 23:59\n
517	0	SAO;VIE;07/02/2014 15:00;09/02/2014 23:59\nVIE;SAO;01/03/2014 12:00;05/03/2014 23:59\n
518	0	GYN;PAR;07/02/2014 15:00;09/02/2014 23:59\nPAR;GYN;01/03/2014 12:00;05/03/2014 23:59\n
519	0	BSB;PAR;07/02/2014 15:00;09/02/2014 23:59\nPAR;BSB;01/03/2014 12:00;05/03/2014 23:59\n
520	0	SAO;PAR;07/02/2014 15:00;09/02/2014 23:59\nPAR;SAO;01/03/2014 12:00;05/03/2014 23:59\n
521	0	GYN;DUB;07/02/2014 15:00;09/02/2014 23:59\nDUB;GYN;01/03/2014 12:00;05/03/2014 23:59\n
522	0	BSB;DUB;07/02/2014 15:00;09/02/2014 23:59\nDUB;BSB;01/03/2014 12:00;05/03/2014 23:59\n
523	0	SAO;DUB;07/02/2014 15:00;09/02/2014 23:59\nDUB;SAO;01/03/2014 12:00;05/03/2014 23:59\n
524	0	GYN;MIA;07/02/2014 15:00;09/02/2014 23:59\nMIA;GYN;01/03/2014 12:00;05/03/2014 23:59\n
525	0	BSB;MIA;07/02/2014 15:00;09/02/2014 23:59\nMIA;BSB;01/03/2014 12:00;05/03/2014 23:59\n
526	0	SAO;MIA;07/02/2014 15:00;09/02/2014 23:59\nMIA;SAO;01/03/2014 12:00;05/03/2014 23:59\n
527	0	GYN;NYC;07/02/2014 15:00;09/02/2014 23:59\nNYC;GYN;01/03/2014 12:00;05/03/2014 23:59\n
528	0	BSB;NYC;07/02/2014 15:00;09/02/2014 23:59\nNYC;BSB;01/03/2014 12:00;05/03/2014 23:59\n
529	0	SAO;NYC;07/02/2014 15:00;09/02/2014 23:59\nNYC;SAO;01/03/2014 12:00;05/03/2014 23:59\n
530	0	GYN;MEX;07/02/2014 15:00;09/02/2014 23:59\nMEX;GYN;01/03/2014 12:00;05/03/2014 23:59\n
531	0	BSB;MEX;07/02/2014 15:00;09/02/2014 23:59\nMEX;BSB;01/03/2014 12:00;05/03/2014 23:59\n
532	0	SAO;MEX;07/02/2014 15:00;09/02/2014 23:59\nMEX;SAO;01/03/2014 12:00;05/03/2014 23:59\n
533	0	GYN;COR;07/02/2014 15:00;09/02/2014 23:59\nCOR;GYN;01/03/2014 12:00;05/03/2014 23:59\n
534	0	BSB;COR;07/02/2014 15:00;09/02/2014 23:59\nCOR;BSB;01/03/2014 12:00;05/03/2014 23:59\n
535	0	SAO;COR;07/02/2014 15:00;09/02/2014 23:59\nCOR;SAO;01/03/2014 12:00;05/03/2014 23:59\n
536	0	GYN;LIM;07/02/2014 15:00;09/02/2014 23:59\nLIM;GYN;01/03/2014 12:00;05/03/2014 23:59\n
537	0	BSB;LIM;07/02/2014 15:00;09/02/2014 23:59\nLIM;BSB;01/03/2014 12:00;05/03/2014 23:59\n
538	0	SAO;LIM;07/02/2014 15:00;09/02/2014 23:59\nLIM;SAO;01/03/2014 12:00;05/03/2014 23:59\n
539	0	GYN;MUC;07/02/2014 15:00;09/02/2014 23:59\nMUC;GYN;01/03/2014 12:00;05/03/2014 23:59\n
540	0	BSB;MUC;07/02/2014 15:00;09/02/2014 23:59\nMUC;BSB;01/03/2014 12:00;05/03/2014 23:59\n
541	0	SAO;MUC;07/02/2014 15:00;09/02/2014 23:59\nMUC;SAO;01/03/2014 12:00;05/03/2014 23:59\n
542	0	GYN;BCN;07/02/2014 15:00;09/02/2014 23:59\nBCN;GYN;01/03/2014 12:00;05/03/2014 23:59\n
543	0	BSB;BCN;07/02/2014 15:00;09/02/2014 23:59\nBCN;BSB;01/03/2014 12:00;05/03/2014 23:59\n
544	0	SAO;BCN;07/02/2014 15:00;09/02/2014 23:59\nBCN;SAO;01/03/2014 12:00;05/03/2014 23:59\n
545	0	GYN;YMQ;07/02/2014 15:00;09/02/2014 23:59\nYMQ;GYN;01/03/2014 12:00;05/03/2014 23:59\n
546	0	BSB;YMQ;07/02/2014 15:00;09/02/2014 23:59\nYMQ;BSB;01/03/2014 12:00;05/03/2014 23:59\n
547	0	SAO;YMQ;07/02/2014 15:00;09/02/2014 23:59\nYMQ;SAO;01/03/2014 12:00;05/03/2014 23:59\n
548	0	GYN;YYZ;07/02/2014 15:00;09/02/2014 23:59\nYYZ;GYN;01/03/2014 12:00;05/03/2014 23:59\n
549	0	BSB;YYZ;07/02/2014 15:00;09/02/2014 23:59\nYYZ;BSB;01/03/2014 12:00;05/03/2014 23:59\n
550	0	SAO;YYZ;07/02/2014 15:00;09/02/2014 23:59\nYYZ;SAO;01/03/2014 12:00;05/03/2014 23:59\n
551	0	GYN;CPT;07/02/2014 15:00;09/02/2014 23:59\nCPT;GYN;01/03/2014 12:00;05/03/2014 23:59\n
552	0	BSB;CPT;07/02/2014 15:00;09/02/2014 23:59\nCPT;BSB;01/03/2014 12:00;05/03/2014 23:59\n
553	0	SAO;CPT;07/02/2014 15:00;09/02/2014 23:59\nCPT;SAO;01/03/2014 12:00;05/03/2014 23:59\n
554	0	GYN;LON;07/02/2014 15:00;09/02/2014 23:59\nLON;GYN;01/03/2014 12:00;05/03/2014 23:59\n
555	0	BSB;LON;07/02/2014 15:00;09/02/2014 23:59\nLON;BSB;01/03/2014 12:00;05/03/2014 23:59\n
556	0	SAO;LON;07/02/2014 15:00;09/02/2014 23:59\nLON;SAO;01/03/2014 12:00;05/03/2014 23:59\n
557	0	GYN;ROM;07/02/2014 15:00;09/02/2014 23:59\nROM;GYN;01/03/2014 12:00;05/03/2014 23:59\n
558	0	BSB;ROM;07/02/2014 15:00;09/02/2014 23:59\nROM;BSB;01/03/2014 12:00;05/03/2014 23:59\n
559	0	SAO;ROM;07/02/2014 15:00;09/02/2014 23:59\nROM;SAO;01/03/2014 12:00;05/03/2014 23:59\n
560	0	GYN;PRG;07/02/2014 15:00;09/02/2014 23:59\nPRG;GYN;01/03/2014 12:00;05/03/2014 23:59\n
561	0	BSB;PRG;07/02/2014 15:00;09/02/2014 23:59\nPRG;BSB;01/03/2014 12:00;05/03/2014 23:59\n
562	0	SAO;PRG;07/02/2014 15:00;09/02/2014 23:59\nPRG;SAO;01/03/2014 12:00;05/03/2014 23:59\n
563	0	GYN;FLO;07/02/2014 15:00;09/02/2014 23:59\nFLO;GYN;01/03/2014 12:00;05/03/2014 23:59\n
564	0	BSB;FLO;07/02/2014 15:00;09/02/2014 23:59\nFLO;BSB;01/03/2014 12:00;05/03/2014 23:59\n
565	0	SAO;FLO;07/02/2014 15:00;09/02/2014 23:59\nFLO;SAO;01/03/2014 12:00;05/03/2014 23:59\n
566	0	GYN;SYD;07/02/2014 15:00;09/02/2014 23:59\nSYD;GYN;01/03/2014 12:00;05/03/2014 23:59\n
567	0	BSB;SYD;07/02/2014 15:00;09/02/2014 23:59\nSYD;BSB;01/03/2014 12:00;05/03/2014 23:59\n
568	0	SAO;SYD;07/02/2014 15:00;09/02/2014 23:59\nSYD;SAO;01/03/2014 12:00;05/03/2014 23:59\n
569	0	GYN;KRK;07/02/2014 15:00;09/02/2014 23:59\nKRK;GYN;01/03/2014 12:00;05/03/2014 23:59\n
570	0	BSB;KRK;07/02/2014 15:00;09/02/2014 23:59\nKRK;BSB;01/03/2014 12:00;05/03/2014 23:59\n
571	0	SAO;KRK;07/02/2014 15:00;09/02/2014 23:59\nKRK;SAO;01/03/2014 12:00;05/03/2014 23:59\n
572	0	GYN;BEG;07/02/2014 15:00;09/02/2014 23:59\nBEG;GYN;01/03/2014 12:00;05/03/2014 23:59\n
573	0	BSB;BEG;07/02/2014 15:00;09/02/2014 23:59\nBEG;BSB;01/03/2014 12:00;05/03/2014 23:59\n
574	0	SAO;BEG;07/02/2014 15:00;09/02/2014 23:59\nBEG;SAO;01/03/2014 12:00;05/03/2014 23:59\n
575	0	GYN;BUD;07/02/2014 15:00;09/02/2014 23:59\nBUD;GYN;01/03/2014 12:00;05/03/2014 23:59\n
576	0	BSB;BUD;07/02/2014 15:00;09/02/2014 23:59\nBUD;BSB;01/03/2014 12:00;05/03/2014 23:59\n
577	0	SAO;BUD;07/02/2014 15:00;09/02/2014 23:59\nBUD;SAO;01/03/2014 12:00;05/03/2014 23:59\n
578	0	GYN;ZRH;07/02/2014 15:00;09/02/2014 23:59\nZRH;GYN;01/03/2014 12:00;05/03/2014 23:59\n
579	0	BSB;ZRH;07/02/2014 15:00;09/02/2014 23:59\nZRH;BSB;01/03/2014 12:00;05/03/2014 23:59\n
580	0	SAO;ZRH;07/02/2014 15:00;09/02/2014 23:59\nZRH;SAO;01/03/2014 12:00;05/03/2014 23:59\n
581	0	GYN;SFO;07/02/2014 15:00;09/02/2014 23:59\nSFO;GYN;01/03/2014 12:00;05/03/2014 23:59\n
582	0	BSB;SFO;07/02/2014 15:00;09/02/2014 23:59\nSFO;BSB;01/03/2014 12:00;05/03/2014 23:59\n
583	0	SAO;SFO;07/02/2014 15:00;09/02/2014 23:59\nSFO;SAO;01/03/2014 12:00;05/03/2014 23:59\n
584	0	GYN;LIS;07/02/2014 15:00;09/02/2014 23:59\nLIS;GYN;01/03/2014 12:00;05/03/2014 23:59\n
585	0	BSB;LIS;07/02/2014 15:00;09/02/2014 23:59\nLIS;BSB;01/03/2014 12:00;05/03/2014 23:59\n
586	0	SAO;LIS;07/02/2014 15:00;09/02/2014 23:59\nLIS;SAO;01/03/2014 12:00;05/03/2014 23:59\n
587	0	GYN;SCL;07/02/2014 15:00;09/02/2014 23:59\nSCL;GYN;01/03/2014 12:00;05/03/2014 23:59\n
588	0	BSB;SCL;07/02/2014 15:00;09/02/2014 23:59\nSCL;BSB;01/03/2014 12:00;05/03/2014 23:59\n
589	0	SAO;SCL;07/02/2014 15:00;09/02/2014 23:59\nSCL;SAO;01/03/2014 12:00;05/03/2014 23:59\n
590	0	GYN;ORL;07/02/2014 15:00;09/02/2014 23:59\nORL;GYN;01/03/2014 12:00;05/03/2014 23:59\n
591	0	BSB;ORL;07/02/2014 15:00;09/02/2014 23:59\nORL;BSB;01/03/2014 12:00;05/03/2014 23:59\n
592	0	SAO;ORL;07/02/2014 15:00;09/02/2014 23:59\nORL;SAO;01/03/2014 12:00;05/03/2014 23:59\n
768	0	GYN;SLA;07/02/2014 15:00;09/02/2014 23:59\r\nSLA;GYN;01/03/2014 12:00;05/03/2014 23:59\r\n
769	0	BSB;SLA;07/02/2014 15:00;09/02/2014 23:59\r\nSLA;BSB;01/03/2014 12:00;05/03/2014 23:59\r\n
770	0	SAO;SLA;07/02/2014 15:00;09/02/2014 23:59\r\nSLA;SAO;01/03/2014 12:00;05/03/2014 23:59\r\n
1087	0	GYN;RIO;07/02/2014 15:00;09/02/2014 23:59\r\nRIO;GYN;01/03/2014 12:00;05/03/2014 23:59\r\n
1088	0	GYN;MIL;07/02/2014 15:00;09/02/2014 23:59\r\nMIL;GYN;01/03/2014 12:00;05/03/2014 23:59\r\n
1089	0	BSB;MIL;07/02/2014 15:00;09/02/2014 23:59\r\nMIL;BSB;01/03/2014 12:00;05/03/2014 23:59\r\n
1090	0	SAO;MIL;07/02/2014 15:00;09/02/2014 23:59\r\nMIL;SAO;01/03/2014 12:00;05/03/2014 23:59\r\n
1091	0	RIO;MIL;07/02/2014 15:00;09/02/2014 23:59\r\nMIL;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1092	0	GYN;FRA;07/02/2014 15:00;09/02/2014 23:59\r\nFRA;GYN;01/03/2014 12:00;05/03/2014 23:59\r\n
1093	0	BSB;FRA;07/02/2014 15:00;09/02/2014 23:59\r\nFRA;BSB;01/03/2014 12:00;05/03/2014 23:59\r\n
1094	0	SAO;FRA;07/02/2014 15:00;09/02/2014 23:59\r\nFRA;SAO;01/03/2014 12:00;05/03/2014 23:59\r\n
1095	0	RIO;FRA;07/02/2014 15:00;09/02/2014 23:59\r\nFRA;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1096	0	RIO;SLA;07/02/2014 15:00;09/02/2014 23:59\r\nSLA;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1097	0	RIO;YEA;07/02/2014 15:00;09/02/2014 23:59\r\nYEA;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1098	0	RIO;AKL;07/02/2014 15:00;09/02/2014 23:59\r\nAKL;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1099	0	RIO;BOG;07/02/2014 15:00;09/02/2014 23:59\r\nBOG;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1100	0	RIO;VIE;07/02/2014 15:00;09/02/2014 23:59\r\nVIE;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1101	0	RIO;PAR;07/02/2014 15:00;09/02/2014 23:59\r\nPAR;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1102	0	RIO;DUB;07/02/2014 15:00;09/02/2014 23:59\r\nDUB;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1103	0	RIO;MIA;07/02/2014 15:00;09/02/2014 23:59\r\nMIA;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1104	0	RIO;NYC;07/02/2014 15:00;09/02/2014 23:59\r\nNYC;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1105	0	RIO;MEX;07/02/2014 15:00;09/02/2014 23:59\r\nMEX;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1106	0	RIO;COR;07/02/2014 15:00;09/02/2014 23:59\r\nCOR;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1107	0	RIO;LIM;07/02/2014 15:00;09/02/2014 23:59\r\nLIM;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1108	0	RIO;MUC;07/02/2014 15:00;09/02/2014 23:59\r\nMUC;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1109	0	RIO;BCN;07/02/2014 15:00;09/02/2014 23:59\r\nBCN;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1110	0	RIO;YMQ;07/02/2014 15:00;09/02/2014 23:59\r\nYMQ;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1111	0	RIO;YYZ;07/02/2014 15:00;09/02/2014 23:59\r\nYYZ;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1112	0	RIO;CPT;07/02/2014 15:00;09/02/2014 23:59\r\nCPT;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1113	0	RIO;LON;07/02/2014 15:00;09/02/2014 23:59\r\nLON;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1114	0	RIO;ROM;07/02/2014 15:00;09/02/2014 23:59\r\nROM;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1115	0	RIO;PRG;07/02/2014 15:00;09/02/2014 23:59\r\nPRG;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1116	0	RIO;FLO;07/02/2014 15:00;09/02/2014 23:59\r\nFLO;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1117	0	RIO;SYD;07/02/2014 15:00;09/02/2014 23:59\r\nSYD;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1118	0	RIO;KRK;07/02/2014 15:00;09/02/2014 23:59\r\nKRK;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1119	0	RIO;BEG;07/02/2014 15:00;09/02/2014 23:59\r\nBEG;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1120	0	RIO;BUD;07/02/2014 15:00;09/02/2014 23:59\r\nBUD;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1121	0	RIO;ZRH;07/02/2014 15:00;09/02/2014 23:59\r\nZRH;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1122	0	RIO;SFO;07/02/2014 15:00;09/02/2014 23:59\r\nSFO;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1123	0	RIO;LIS;07/02/2014 15:00;09/02/2014 23:59\r\nLIS;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1124	0	RIO;SCL;07/02/2014 15:00;09/02/2014 23:59\r\nSCL;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
1125	0	RIO;ORL;07/02/2014 15:00;09/02/2014 23:59\r\nORL;RIO;01/03/2014 12:00;05/03/2014 23:59\r\n
\.


--
-- TOC entry 1786 (class 2606 OID 16402)
-- Dependencies: 1504 1504
-- Name: best_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY best_price
    ADD CONSTRAINT best_price_pkey PRIMARY KEY (id);


--
-- TOC entry 1790 (class 2606 OID 16416)
-- Dependencies: 1507 1507
-- Name: exchange_rate_day_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY exchange_rate
    ADD CONSTRAINT exchange_rate_day_key UNIQUE (day);


--
-- TOC entry 1792 (class 2606 OID 16414)
-- Dependencies: 1507 1507
-- Name: exchange_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY exchange_rate
    ADD CONSTRAINT exchange_rate_pkey PRIMARY KEY (id);


--
-- TOC entry 1788 (class 2606 OID 16404)
-- Dependencies: 1506 1506
-- Name: query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY query
    ADD CONSTRAINT query_pkey PRIMARY KEY (id);


--
-- TOC entry 1793 (class 2606 OID 16405)
-- Dependencies: 1787 1504 1506
-- Name: fk4e132f2ebf598717; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY best_price
    ADD CONSTRAINT fk4e132f2ebf598717 FOREIGN KEY (query_id) REFERENCES query(id);


--
-- TOC entry 1801 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-09-16 12:57:04

--
-- PostgreSQL database dump complete
--

