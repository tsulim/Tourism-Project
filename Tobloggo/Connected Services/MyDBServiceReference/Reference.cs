﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Tobloggo.MyDBServiceReference {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="CompositeType", Namespace="http://schemas.datacontract.org/2004/07/DBService")]
    [System.SerializableAttribute()]
    public partial class CompositeType : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private bool BoolValueField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string StringValueField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool BoolValue {
            get {
                return this.BoolValueField;
            }
            set {
                if ((this.BoolValueField.Equals(value) != true)) {
                    this.BoolValueField = value;
                    this.RaisePropertyChanged("BoolValue");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string StringValue {
            get {
                return this.StringValueField;
            }
            set {
                if ((object.ReferenceEquals(this.StringValueField, value) != true)) {
                    this.StringValueField = value;
                    this.RaisePropertyChanged("StringValue");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="User", Namespace="http://schemas.datacontract.org/2004/07/DBService.Entity")]
    [System.SerializableAttribute()]
    public partial class User : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private int AuthorizationField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ContactField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string EmailField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string GoogleIdField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string IVField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string IdField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string KeyField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NameField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string PasswordHashField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string PasswordSaltField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ProfImageField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string StripeIdField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public int Authorization {
            get {
                return this.AuthorizationField;
            }
            set {
                if ((this.AuthorizationField.Equals(value) != true)) {
                    this.AuthorizationField = value;
                    this.RaisePropertyChanged("Authorization");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Contact {
            get {
                return this.ContactField;
            }
            set {
                if ((object.ReferenceEquals(this.ContactField, value) != true)) {
                    this.ContactField = value;
                    this.RaisePropertyChanged("Contact");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Email {
            get {
                return this.EmailField;
            }
            set {
                if ((object.ReferenceEquals(this.EmailField, value) != true)) {
                    this.EmailField = value;
                    this.RaisePropertyChanged("Email");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string GoogleId {
            get {
                return this.GoogleIdField;
            }
            set {
                if ((object.ReferenceEquals(this.GoogleIdField, value) != true)) {
                    this.GoogleIdField = value;
                    this.RaisePropertyChanged("GoogleId");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string IV {
            get {
                return this.IVField;
            }
            set {
                if ((object.ReferenceEquals(this.IVField, value) != true)) {
                    this.IVField = value;
                    this.RaisePropertyChanged("IV");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Id {
            get {
                return this.IdField;
            }
            set {
                if ((object.ReferenceEquals(this.IdField, value) != true)) {
                    this.IdField = value;
                    this.RaisePropertyChanged("Id");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Key {
            get {
                return this.KeyField;
            }
            set {
                if ((object.ReferenceEquals(this.KeyField, value) != true)) {
                    this.KeyField = value;
                    this.RaisePropertyChanged("Key");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Name {
            get {
                return this.NameField;
            }
            set {
                if ((object.ReferenceEquals(this.NameField, value) != true)) {
                    this.NameField = value;
                    this.RaisePropertyChanged("Name");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string PasswordHash {
            get {
                return this.PasswordHashField;
            }
            set {
                if ((object.ReferenceEquals(this.PasswordHashField, value) != true)) {
                    this.PasswordHashField = value;
                    this.RaisePropertyChanged("PasswordHash");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string PasswordSalt {
            get {
                return this.PasswordSaltField;
            }
            set {
                if ((object.ReferenceEquals(this.PasswordSaltField, value) != true)) {
                    this.PasswordSaltField = value;
                    this.RaisePropertyChanged("PasswordSalt");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ProfImage {
            get {
                return this.ProfImageField;
            }
            set {
                if ((object.ReferenceEquals(this.ProfImageField, value) != true)) {
                    this.ProfImageField = value;
                    this.RaisePropertyChanged("ProfImage");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string StripeId {
            get {
                return this.StripeIdField;
            }
            set {
                if ((object.ReferenceEquals(this.StripeIdField, value) != true)) {
                    this.StripeIdField = value;
                    this.RaisePropertyChanged("StripeId");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="Location", Namespace="http://schemas.datacontract.org/2004/07/DBService.Entity")]
    [System.SerializableAttribute()]
    public partial class Location : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string AddressField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ImagesField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NameField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private bool StatusField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string TypeField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private int UserIdField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Address {
            get {
                return this.AddressField;
            }
            set {
                if ((object.ReferenceEquals(this.AddressField, value) != true)) {
                    this.AddressField = value;
                    this.RaisePropertyChanged("Address");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Images {
            get {
                return this.ImagesField;
            }
            set {
                if ((object.ReferenceEquals(this.ImagesField, value) != true)) {
                    this.ImagesField = value;
                    this.RaisePropertyChanged("Images");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Name {
            get {
                return this.NameField;
            }
            set {
                if ((object.ReferenceEquals(this.NameField, value) != true)) {
                    this.NameField = value;
                    this.RaisePropertyChanged("Name");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool Status {
            get {
                return this.StatusField;
            }
            set {
                if ((this.StatusField.Equals(value) != true)) {
                    this.StatusField = value;
                    this.RaisePropertyChanged("Status");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Type {
            get {
                return this.TypeField;
            }
            set {
                if ((object.ReferenceEquals(this.TypeField, value) != true)) {
                    this.TypeField = value;
                    this.RaisePropertyChanged("Type");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public int UserId {
            get {
                return this.UserIdField;
            }
            set {
                if ((this.UserIdField.Equals(value) != true)) {
                    this.UserIdField = value;
                    this.RaisePropertyChanged("UserId");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="MyDBServiceReference.IService1")]
    public interface IService1 {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetData", ReplyAction="http://tempuri.org/IService1/GetDataResponse")]
        string GetData(int value);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetData", ReplyAction="http://tempuri.org/IService1/GetDataResponse")]
        System.Threading.Tasks.Task<string> GetDataAsync(int value);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetDataUsingDataContract", ReplyAction="http://tempuri.org/IService1/GetDataUsingDataContractResponse")]
        Tobloggo.MyDBServiceReference.CompositeType GetDataUsingDataContract(Tobloggo.MyDBServiceReference.CompositeType composite);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetDataUsingDataContract", ReplyAction="http://tempuri.org/IService1/GetDataUsingDataContractResponse")]
        System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.CompositeType> GetDataUsingDataContractAsync(Tobloggo.MyDBServiceReference.CompositeType composite);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/CreateUser", ReplyAction="http://tempuri.org/IService1/CreateUserResponse")]
        int CreateUser(string name, string passwordHash, string passwordSalt, string email, string contact, string iv, string key);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/CreateUser", ReplyAction="http://tempuri.org/IService1/CreateUserResponse")]
        System.Threading.Tasks.Task<int> CreateUserAsync(string name, string passwordHash, string passwordSalt, string email, string contact, string iv, string key);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/CreateOrFindSingleGoogleUser", ReplyAction="http://tempuri.org/IService1/CreateOrFindSingleGoogleUserResponse")]
        int CreateOrFindSingleGoogleUser(string googleId, string name, string email);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/CreateOrFindSingleGoogleUser", ReplyAction="http://tempuri.org/IService1/CreateOrFindSingleGoogleUserResponse")]
        System.Threading.Tasks.Task<int> CreateOrFindSingleGoogleUserAsync(string googleId, string name, string email);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/UpdateUser", ReplyAction="http://tempuri.org/IService1/UpdateUserResponse")]
        int UpdateUser(Tobloggo.MyDBServiceReference.User user);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/UpdateUser", ReplyAction="http://tempuri.org/IService1/UpdateUserResponse")]
        System.Threading.Tasks.Task<int> UpdateUserAsync(Tobloggo.MyDBServiceReference.User user);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetUserById", ReplyAction="http://tempuri.org/IService1/GetUserByIdResponse")]
        Tobloggo.MyDBServiceReference.User GetUserById(string id);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetUserById", ReplyAction="http://tempuri.org/IService1/GetUserByIdResponse")]
        System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.User> GetUserByIdAsync(string id);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetUserByEmail", ReplyAction="http://tempuri.org/IService1/GetUserByEmailResponse")]
        Tobloggo.MyDBServiceReference.User GetUserByEmail(string email);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetUserByEmail", ReplyAction="http://tempuri.org/IService1/GetUserByEmailResponse")]
        System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.User> GetUserByEmailAsync(string email);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetAllUsers", ReplyAction="http://tempuri.org/IService1/GetAllUsersResponse")]
        Tobloggo.MyDBServiceReference.User[] GetAllUsers();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetAllUsers", ReplyAction="http://tempuri.org/IService1/GetAllUsersResponse")]
        System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.User[]> GetAllUsersAsync();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetAllLocations", ReplyAction="http://tempuri.org/IService1/GetAllLocationsResponse")]
        Tobloggo.MyDBServiceReference.Location[] GetAllLocations();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetAllLocations", ReplyAction="http://tempuri.org/IService1/GetAllLocationsResponse")]
        System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.Location[]> GetAllLocationsAsync();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/CreateLocation", ReplyAction="http://tempuri.org/IService1/CreateLocationResponse")]
        int CreateLocation(string name, string address, string type, string images, bool status, int userid);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/CreateLocation", ReplyAction="http://tempuri.org/IService1/CreateLocationResponse")]
        System.Threading.Tasks.Task<int> CreateLocationAsync(string name, string address, string type, string images, bool status, int userid);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IService1Channel : Tobloggo.MyDBServiceReference.IService1, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class Service1Client : System.ServiceModel.ClientBase<Tobloggo.MyDBServiceReference.IService1>, Tobloggo.MyDBServiceReference.IService1 {
        
        public Service1Client() {
        }
        
        public Service1Client(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public Service1Client(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public Service1Client(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public Service1Client(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public string GetData(int value) {
            return base.Channel.GetData(value);
        }
        
        public System.Threading.Tasks.Task<string> GetDataAsync(int value) {
            return base.Channel.GetDataAsync(value);
        }
        
        public Tobloggo.MyDBServiceReference.CompositeType GetDataUsingDataContract(Tobloggo.MyDBServiceReference.CompositeType composite) {
            return base.Channel.GetDataUsingDataContract(composite);
        }
        
        public System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.CompositeType> GetDataUsingDataContractAsync(Tobloggo.MyDBServiceReference.CompositeType composite) {
            return base.Channel.GetDataUsingDataContractAsync(composite);
        }
        
        public int CreateUser(string name, string passwordHash, string passwordSalt, string email, string contact, string iv, string key) {
            return base.Channel.CreateUser(name, passwordHash, passwordSalt, email, contact, iv, key);
        }
        
        public System.Threading.Tasks.Task<int> CreateUserAsync(string name, string passwordHash, string passwordSalt, string email, string contact, string iv, string key) {
            return base.Channel.CreateUserAsync(name, passwordHash, passwordSalt, email, contact, iv, key);
        }
        
        public int CreateOrFindSingleGoogleUser(string googleId, string name, string email) {
            return base.Channel.CreateOrFindSingleGoogleUser(googleId, name, email);
        }
        
        public System.Threading.Tasks.Task<int> CreateOrFindSingleGoogleUserAsync(string googleId, string name, string email) {
            return base.Channel.CreateOrFindSingleGoogleUserAsync(googleId, name, email);
        }
        
        public int UpdateUser(Tobloggo.MyDBServiceReference.User user) {
            return base.Channel.UpdateUser(user);
        }
        
        public System.Threading.Tasks.Task<int> UpdateUserAsync(Tobloggo.MyDBServiceReference.User user) {
            return base.Channel.UpdateUserAsync(user);
        }
        
        public Tobloggo.MyDBServiceReference.User GetUserById(string id) {
            return base.Channel.GetUserById(id);
        }
        
        public System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.User> GetUserByIdAsync(string id) {
            return base.Channel.GetUserByIdAsync(id);
        }
        
        public Tobloggo.MyDBServiceReference.User GetUserByEmail(string email) {
            return base.Channel.GetUserByEmail(email);
        }
        
        public System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.User> GetUserByEmailAsync(string email) {
            return base.Channel.GetUserByEmailAsync(email);
        }
        
        public Tobloggo.MyDBServiceReference.User[] GetAllUsers() {
            return base.Channel.GetAllUsers();
        }
        
        public System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.User[]> GetAllUsersAsync() {
            return base.Channel.GetAllUsersAsync();
        }
        
        public Tobloggo.MyDBServiceReference.Location[] GetAllLocations() {
            return base.Channel.GetAllLocations();
        }
        
        public System.Threading.Tasks.Task<Tobloggo.MyDBServiceReference.Location[]> GetAllLocationsAsync() {
            return base.Channel.GetAllLocationsAsync();
        }
        
        public int CreateLocation(string name, string address, string type, string images, bool status, int userid) {
            return base.Channel.CreateLocation(name, address, type, images, status, userid);
        }
        
        public System.Threading.Tasks.Task<int> CreateLocationAsync(string name, string address, string type, string images, bool status, int userid) {
            return base.Channel.CreateLocationAsync(name, address, type, images, status, userid);
        }
    }
}
