{-
   Copyright 2022 Morgan Stanley
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at
       http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-}

module Regulation.US.FR2052A.Fields.Counterparty exposing (..)

{-|
The following counterparty types are used across all tables except the Inflow-Assets,
Supplemental-Informational, and Comment tables.
8 The definitions for these types should align
with the classification of the legal counterparty to a given exposure and not the counterparty’s
ultimate parent; however two product-specific exceptions to this approach are detailed below
in the definitions of the Debt Issuing SPE and Bank counterparty types.


* **Retail** Refers to a counterparty who is a natural person. Retail includes a living or testamentary
trust that is solely for the benefit of natural persons, does not have a corporate trustee,
and terminates within 21 years and 10 months after the death of grantors or 
beneficiaries of the trust living on the effective date of the trust or within 25 years, if 
applicable under state law. Retail does not include other legal entities, sole 
proprietorships, or partnerships. Other legal entities, proprietorships and partnerships 
should be reported, as appropriate, in one of the sub-products as defined below.
* **Small Business** Refers to entities managed as retail exposures that exhibit the same liquidity risk
characteristics as retail customers. The total aggregate funding raised from these 
entities should not exceed $1.5 million from the perspective of the consolidated 
reporting entity. Under circumstances where small business entities are affiliated, the
$1.5 million threshold should be assessed against the aggregate funding exposures of 
the affiliated group.
* **Non-Financial Corporate** Refers to commercial entities that are not owned by central governments, local
governments or local authorities with revenue-raising powers, and that are nonfinancial in nature (i.e., do not meet the definition of Pension Fund, Bank, Broker-Dealer, 
Investment Company or Advisor, Financial Market Utility, Other Supervised Non-Bank 
Financial Entity, or Non-Regulated Fund as identified in the sections below).
* **Sovereign** Refers to a central government or an agency, department or ministry.
* **Central Bank** Refers to a bank responsible for implementing its jurisdiction’s monetary policy.
* **Government Sponsored Entity (GSE)** Refers to entities established or chartered by the Federal government to serve public
purposes specified by the United States Congress, but whose debt obligations are not 
explicitly guaranteed by the full faith and credit of the United States government.
* **Public Sector Entity (PSE)** Refers to a state, local authority, or other governmental subdivision below the sovereign
level.
* **Multilateral Development Bank (MDB)** Refers to the International Bank for Reconstruction and Development, the Multilateral
Investment Guarantee Agency, the International Finance Corporation, the InterAmerican Development Bank, the Asian Development Bank, the African Development 
Bank, the European Bank for Reconstruction and Development, the European 
Investment Bank, the European Investment Fund, the Nordic Investment Bank, the 
Caribbean Development Bank, the Islamic Development Bank, the Council of Europe 
Development Bank, and any other entity that provides financing for national or regional 
development in which the U.S. government is a shareholder or contributing member or 
which the appropriate Federal banking agency determines poses comparable risk.
* **Other Supranational** International or regional organizations or subordinate or affiliated agencies thereof,
created by treaty or convention between sovereign states that are not multilateral 
development banks, including the International Monetary Fund, the Bank for 
International Settlements, and the United Nations.
* **Pension Fund** Refers to an employee benefit plan as defined in paragraphs (3) and (32) of section 3 of
the Employee Retirement Income and Security Act of 1974 (29 U.S.C. 1001 et seq.), a 
“governmental plan” (as defined in 29 U.S.C. 1002(32)) that complies with the tax 
deferral qualification requirements provided in the Internal Revenue Code, or any 
similar employee benefit plan established under the laws of a foreign jurisdiction.
* **Bank** Refers to a depository institution; bank holding company or savings and loan holding
company; foreign bank; credit union; industrial loan company, industrial bank, or other 
similar institution described in section 2 of the Bank Holding Company Act of 1956, as 
amended (12 U.S.C. 1841 et seq.); national bank, state member bank, or state nonmember bank that is not a depository institution. This term does not include non-bank 
financial entities that have an affiliated banking entity, except for exposures reported in 
the Outflows-Other table under products O.O.4: Credit Facilities and O.O.5: Liquidity 
Facilities. Any company that is not a bank but is included in the organization chart of a 
bank holding company or savings and loan holding company on the Form FR Y-6, as 
listed in the hierarchy report of the bank holding company or savings and loan holding 
company produced by the National Information Center (NIC) Web site, must be 
designated as a Bank for products O.O.4 and O.O.5. This term does not include bridge 
financial companies as defined in 12 U.S.C. 5381(a)(3), or new depository institutions or 
bridge depository institutions as defined in 12 U.S.C. 1813(i).
* **Broker-Dealer** Refers to a securities holding company as defined in section 618 of the Dodd-Frank Act
(12 U.S.C. 1850a); broker or dealer registered with the SEC under section 15 of the 
Securities Exchange Act (15 U.S.C. 78o); futures commission merchant as defined in 
section 1a of the Commodity Exchange Act of 1936 (7 U.S.C. 1 et seq.); swap dealer as 
defined in section 1a of the Commodity Exchange Act (7 U.S.C. 1a); security-based swap 
dealer as defined in section 3 of the Securities Exchange Act (15 U.S.C. 78c); or any 
company not domiciled in the United States (or a political subdivision thereof) that is 
supervised and regulated in a manner similar to these entities.
* **Investment Company or Advisor** Refers to a person or company registered with the SEC under the Investment Company
Act of 1940 (15 U.S.C. 80a-1 et seq.); a company registered with the SEC as an 
investment adviser under the Investment Advisers Act of 1940 (15 U.S.C. 80b-1 et seq.); 
or foreign equivalents of such persons or companies. An investment company or advisor 
does not include small business investment companies, as defined in section 102 of the 
Small Business Investment Act of 1958 (15 U.S.C. 661 et seq.).
* **Financial Market Utility** Refers to a designated financial market utility, as defined in section 803 of the DoddFrank Act (12 U.S.C. 5462) and any company not domiciled in the United States (or a
political subdivision thereof) that is supervised and regulated in a similar manner.
* **Other Supervised Non-Bank Financial Entity**
 1. A company that the Financial Stability Oversight Council has determined under
section 113 of the Dodd-Frank Act (12 U.S.C. 5323) shall be supervised by the Board 
of Governors of the Federal Reserve System and for which such determination is still 
in effect; 
 2. A company that is not a bank, broker-dealer, investment company or advisor or
financial market utility, but is included in the organization chart of a bank holding 
company or savings and loan holding company on the Form FR Y-6, as listed in the 
hierarchy report of the bank holding company or savings and loan holding company 
produced by the National Information Center (NIC) Web site;
 3. An insurance company; and
 4. Any company not domiciled in the United States (or a political subdivision thereof)
that is supervised and regulated in a manner similar to entities described in 
paragraphs (1) through (3) of this definition (e.g., a non-bank subsidiary of a foreign 
banking organization, foreign insurance company, etc.).
 5. A supervised non-bank financial entity does not include:
  a. U.S. government-sponsored enterprises;
  b. Entities designated as Community Development Financial Institutions (CDFIs)  under 12 U.S.C. 4701 et seq. and 12 CFR part 1805; or
  c. Central banks, the Bank for International Settlements, the International Monetary Fund, or multilateral development banks.
* **Debt Issuing Special Purpose Entity (SPE)** efers to an SPE9 that issues or has issued commercial paper or securities (other than
equity securities issued to a company of which the SPE is a consolidated subsidiary) to 
finance its purchases or operations. This counterparty type should only be used to 
identify stand-alone SPEs that issue debt and are not consolidated on an affiliated 
entity’s balance sheet for purposes of financial reporting, except for exposures reported 
in the Outflows-Other table under products O.O.4: Credit Facilities and O.O.5: Liquidity 
Facilities. All debt issuing SPEs should be identified as Debt Issuing SPEs for products 
O.O.4 and O.O.5, regardless of whether they are consolidated by an affiliate for financial 
reporting.
* **Non-Regulated Fund** Refers to a hedge fund or private equity fund whose investment advisor is required to
file SEC Form PF (Reporting Form for Investment Advisers to Private Funds and Certain 
Commodity Pool Operators and Commodity Trading Advisors), other than a small 
business investment company as defined in section 102 of the Small Business 
Investment Act of 1958 (15 U.S.C. 661 et seq.)).
* **Other** Refers to any counterparty that does not fall into any of the above categories. Consult
with your supervisory team before reporting balances using this counterparty type. Use 
the comments table to provide description of the counterparty on at least a 
monthly basis and in the event of a material change in reported values.

-}

type Counterparty 
    = Retail
    | Small_Business
    | Non_Financial_Corporate
    | Sovereign
    | Central_Bank
    | Government_Sponsored_Entity
    | Public_Sector_Entity
    | Multilateral_Development_Bank
    | Other_Supranational
    | Pension_Fund
    | Bank
    | Broker_Dealer
    | Investment_Company_or_Advisor
    | Financial_Market_Utility
    | Other_Supervised_Non_Bank_Financial_Entity
    | Debt_Issuing_Special_Purpose_Entity
    | Non_Regulated_Fund
    | Other
