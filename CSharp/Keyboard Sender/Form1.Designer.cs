namespace App
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.tbLog = new System.Windows.Forms.TextBox();
            this.tmrPing = new System.Windows.Forms.Timer(this.components);
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.button6 = new System.Windows.Forms.Button();
            this.tmrRelease = new System.Windows.Forms.Timer(this.components);
            this.SuspendLayout();
            // 
            // tbLog
            // 
            this.tbLog.Location = new System.Drawing.Point(12, 12);
            this.tbLog.Multiline = true;
            this.tbLog.Name = "tbLog";
            this.tbLog.Size = new System.Drawing.Size(749, 286);
            this.tbLog.TabIndex = 0;
            this.tbLog.Text = resources.GetString("tbLog.Text");
            // 
            // tmrPing
            // 
            this.tmrPing.Interval = 200;
            this.tmrPing.Tick += new System.EventHandler(this.tmrPing_Tick);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(12, 310);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(269, 27);
            this.button1.TabIndex = 1;
            this.button1.Text = "Press \'a\' for 50ms, then release";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(12, 350);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(269, 27);
            this.button2.TabIndex = 2;
            this.button2.Text = "Press \'a\' for 2000ms, then release";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(12, 391);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(269, 27);
            this.button3.TabIndex = 3;
            this.button3.Text = "Clear the Reader log";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(296, 391);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(465, 27);
            this.button4.TabIndex = 6;
            this.button4.Text = "Press \'a\' then forget to release it (stuck key).  Read code comments first.";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(296, 350);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(379, 27);
            this.button5.TabIndex = 5;
            this.button5.Text = "Send \'Hello\' with 50ms down and 100ms interkey delay";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // button6
            // 
            this.button6.Location = new System.Drawing.Point(296, 310);
            this.button6.Name = "button6";
            this.button6.Size = new System.Drawing.Size(379, 27);
            this.button6.TabIndex = 4;
            this.button6.Text = "Press \'a\' and \'b\' simultaneously for 50ms, then release";
            this.button6.UseVisualStyleBackColor = true;
            this.button6.Click += new System.EventHandler(this.button6_Click);
            // 
            // tmrRelease
            // 
            this.tmrRelease.Interval = 2000;
            this.tmrRelease.Tick += new System.EventHandler(this.tmrRelease_Tick);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(773, 425);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.button6);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.tbLog);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Tetherscript Virtual Keyboard Driver Sender";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Shown += new System.EventHandler(this.Form1_Shown);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox tbLog;
        private System.Windows.Forms.Timer tmrPing;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Button button6;
        private System.Windows.Forms.Timer tmrRelease;
    }
}

